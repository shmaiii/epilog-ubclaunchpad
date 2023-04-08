import express from 'express';

import medicationsController from '../controllers/medicationsController.js';

const router = express.Router();

router.get('/read', medicationsController.getMedications);
router.post('/add', medicationsController.addMedication);
router.post('/:mid/edit', medicationsController.editMedication);
router.post('/:mid/delete', medicationsController.deleteMedication);

export default router;