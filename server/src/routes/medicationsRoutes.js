import express from 'express';

import medicationsController from '../controllers/medicationsController.js';

const router = express.Router();

router.get('/user/:id/medications/read', medicationsController.getMedications);
router.post('/user/:id/medications/add', medicationsController.addMedication);
router.post('/user/:uid/medications/:mid/edit', medicationsController.editMedication);
router.post('/user/:uid/medications/:mid/delete', medicationsController.deleteMedication);

export default router;