import express from 'express';

import calendarController from '../controllers/calendarController.js';

const router = express.Router();

router.get('/:user', calendarController.getAllCalendarDocuments);
router.get('/:calendarDocId', calendarController.getCalendarDocumentGivenId);
router.post('/', calendarController.postCalendarDocument);
router.put('/:calendarDocId', calendarController.updateCalendarDocumentGivenId)
router.delete('/:calendarDocId', calendarController.deleteCalendarDocumentGivenId)

export default router;
