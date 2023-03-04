import express from 'express';
import cors from 'cors';
import videoRoutes from './routes/videoRoutes.js';


const app = express();

app.use(express.json());
app.use(cors());
app.use('/videos', videoRoutes);

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
})
