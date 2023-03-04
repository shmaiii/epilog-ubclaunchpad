import express from 'express';
import videoController from '../controllers/videoController.js';

const router = express.Router();

router.get('/:id', videoController.getVideoDoc);
router.get('/', videoController.getAllVideos);

export default router;
