import express from 'express';

import userController from '../controllers/userController.js';

const router = express.Router();

router.get('/:id/personal-information/read', userController.getPersonalInformation);
router.post('/personal-information/store', userController.storePersonalInformation);
export default router;