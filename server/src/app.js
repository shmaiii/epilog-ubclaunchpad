import express from "express";
import cors from "cors";
import {router} from './routes/entries.js'
import noLocationRoutes from "./routes/noLocationRoutes.js";
import userRoutes from "./routes/userRoutes.js";
import medicationsRoutes from "./routes/medicationsRoutes.js";
import contactsRoutes from "./routes/contactsRoutes.js";
import calendarRoutes from "./routes/calendarRoutes.js";
import { auth } from "./firebase/auth.js";
import { getBearerTokenFromHeader } from "./utils/index.js";


const app = express();
app.use(express.json());
app.use(cors());

// Auth middleware
app.use(async (req, res, next) => {
  try {
    const idToken = getBearerTokenFromHeader(req);

    if (idToken === null) {
      const error = new Error(
        "request does not have a valid authorization header"
      );
      error.code = 401;
      throw error;
    }

    const decodedIdToken = await auth.verifyIdToken(idToken);

    // Attach userID used to identify firebase user making the http request to the req object
    req.firebaseUserId = decodedIdToken.uid;

    // Console log for testing. Need to remove later
    console.log(`uid is: ${req.firebaseUserId}`);
    next();
  } catch (err) {
    let error = err;
    if (err.errorInfo?.code === "auth/argument-error") {
      error = new Error("request does not have a valid authorization header");
      error.code = 401;
    }
    next(error);
  }
});

app.use("/noLocation", noLocationRoutes);

// Location middleware
app.use(async (req, res, next) => {
  // Canada or USA
  req.userLocation = req.headers["user-location"];
  if (!req.userLocation) {
    const userLocationError = new Error("User-Location header is empty");
    userLocationError.code = 400;
    return next(userLocationError);
  }

  return next();
});

app.use("/user", userRoutes);
app.use("/medications", medicationsRoutes);
app.use("/contacts", contactsRoutes);
app.use("/calendar", calendarRoutes);
app.use('/entries', router);

app.get("/ping", (req, res) => {
  console.log("pong");
  res.status(200).send("pong");
});



app.use('/entries', router)



app.use('/entries', router)



app.use('/entries', router)



app.use('/entries', router)

app.use((error, req, res, next) => {
  return res.status(error.code ?? 500).json({ err: error.message });
});

const PORT = process.env.port || 8080;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

