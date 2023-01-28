require('dotenv').config();
import express from 'express';
import cors from 'cors';

const Mux = require("@mux/mux-node");
const { Video } = new Mux(
    process.env.MUX_TOKEN_ID,
    process.env.MUX_SECRET_KEY
);

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

// API routes for video processing
app.post("/assets", async(req, res) => {
    console.log("body: " + req.body.videoUrl);

    const asset = await Video.Assets.create({
        input: req.body.videoUrl,
        playback_policy: "public",
    });

    res.json({
        data: {
            id: asset.id,
            status: asset.status,
            playback_ids: asset.playback_ids,
            created_at: asset.created_at,
        },
    });
});

app.get("/assets", async(req, res) => {
    const assets = await Video.Assets.list();

    res.json({
        data: assets.map((asset) => ({
            id: asset.id,
            status: asset.status,
            playback_ids: asset.created_at,
            duration: asset.duration,
            max_stored_resolution: asset.max_stored_resolution,
            max_stored_frame_rate: asset.max_stored_frame_rate,
            aspect_ratio: asset.aspect_ratio,
        })),
    });
});

app.get("/asset", async (req, res) => {
    let videoId = req.query.videoId;
    const asset = await Video.Assets.get(videoId);

    console.log(asset);

    res.json({
        data: {
            id: asset.id,
            status: asset.status,
            playback_ids: asset.created_at,
            duration: asset.duration,
            max_stored_resolution: asset.max_stored_resolution,
            max_stored_frame_rate: asset.max_stored_frame_rate,
            aspect_ratio: asset.aspect_ratio,
        },
    });
});