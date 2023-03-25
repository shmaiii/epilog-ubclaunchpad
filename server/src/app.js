import express from 'express';
import cors from 'cors';
import {router} from './routes/entries.js'
import userRoutes from './routes/userRoutes.js';
import medicationsRoutes from './routes/medicationsRoutes.js';
import contactsRoutes from './routes/contactsRoutes.js';
import calendarRoutes from './routes/calendarRoutes.js';
import { auth } from './firebase/auth.js';
import { getBearerTokenFromHeader } from './utils/index.js';

const app = express();
app.use(express.json());
app.use(cors());

app.use(async (req, res, next) => {
    try {
        // const idToken = getBearerTokenFromHeader(req);

        // if (idToken === null) {
        //     const error = new Error("request does not have a valid authorization header");
        //     error.code = 401;
        //     throw error;
        // }

        // const decodedIdToken = await auth.verifyIdToken(idToken);

        // // Attach userID used to identify firebase user making the http request to the req object
        // req.firebaseUserId = decodedIdToken.uid;

        // // Console log for testing. Need to remove later
        // console.log(`uid is: ${req.firebaseUserId}`)
        
        req.firebaseUserId = getBearerTokenFromHeader(req);
        console.log(req.firebaseUserId);
        next()
    } catch (err){
        let error = err
        if (err.errorInfo?.code === 'auth/argument-error') {
            error = new Error("request does not have a valid authorization header");
            error.code = 401;
        }
        next(error)
    }
})

app.use('/user', userRoutes);
app.use('/medications', medicationsRoutes);
app.use('/contacts', contactsRoutes);
app.use('/calendar', calendarRoutes);

app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});



app.use('/entries', router)

app.use((error, req, res, next) => {
    console.log(error)
    return res.status(error.code ?? 400).json({err: error.message})
});

const PORT = process.env.port || 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
});

