import express from 'express';
import {db} from "../src/firebase/db.js";

const router = express.Router();

router.get('/:id/video');

export default router
