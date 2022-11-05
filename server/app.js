import express from 'express';
import cors from 'cors';
import {router} from './routing/entries.js'

const app = express();
app.use(express.json());
app.use(cors());

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})

app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});
app.use('/entries', router)