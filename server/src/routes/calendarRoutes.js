import express from 'express';

import calendarController from '../controllers/calendarController.js';

const router = express.Router();

router.get('/', calendarController.getAllCalendarDocuments);
router.get('/:calendarDocId', calendarController.getCalendarDocumentGivenId);
router.post('/', calendarController.postCalendarDocument);
router.put('/:calendarDocId', calendarController.updateCalendarDocumentGivenId)
router.patch('/updateDate/:calendarDocId', calendarController.updateCalendarDocumentDateGivenId);
router.patch('/updateTake/:calendarDocId', calendarController.updateCalendarDocumentTakeGivenId);
router.delete('/:calendarDocId', calendarController.deleteCalendarDocumentGivenId)

export default router;
