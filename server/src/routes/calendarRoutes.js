import express from 'express';

import calendarController from '../controllers/calendarController.js';

const router = express.Router();

router.get('/:user', calendarController.getAllCalendarDocuments);
router.get('/:id', calendarController.getCalendarDocumentGivenId);
router.post('/', calendarController.postCalendarDocument);
router.put('/:id', calendarController.updateCalendarDocumentGivenId)
router.delete('/:id', calendarController.deleteCalendarDocumentGivenId)

export default router;
