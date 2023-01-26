import express from 'express';
import cors from 'cors';

const app = express();

app.use(express.json());
app.use(cors());

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})
app.get('/', (req, res) => {
    console.log("connected");
    res.status(200).send("connected");
});
app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});



