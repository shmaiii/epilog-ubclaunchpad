import express from 'express';
import cors from 'cors';
import calendarRoutes from './routes/calendarRoutes.js';


const app = express();

app.use(express.json());
app.use(cors());

app.use('/calendar', calendarRoutes);

app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});

app.use((error, req, res, next) => {
    console.log(error)
    const errorStatus = error.statusCode || 400;
    return res.status(errorStatus).json({err: error.message})
});

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
});
