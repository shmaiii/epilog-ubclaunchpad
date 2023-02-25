import express from 'express';
import cors from 'cors';
import calendarRoutes from './routes/calendarRoutes.js';
import { auth } from './firebase/auth.js';
import { getBearerTokenFromHeader } from './utils/index.js';

const app = express();
app.use(express.json());
app.use(cors());

app.use(async (req, res, next) => {
    try {
        const idToken = getBearerTokenFromHeader(req);

        if (idToken === null) {
            const error = new Error("request does not have valid authorization header");
            error.code = 401;
            throw error;
        }

        const decodedIdToken = await auth.verifyIdToken(idToken);
        req.firebaseUserId = decodedIdToken.uid;
        console.log(`uid is: ${req.firebaseUserId}`)
        next()
    } catch (err){
        next(err)
    }
})

app.use('/calendar', calendarRoutes);

app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});

app.use((error, req, res, next) => {
    console.log(error)
    return res.status(error.code ?? 400).json({err: error.message})
});

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
});
