import express from 'express';

import calendarController from '../controllers/calendarController.js';

const router = express.Router();

router.get('/:user', calendarController.getAllCalendarDocuments);
router.get('/:user/:calendarDocId', calendarController.getCalendarDocumentGivenId);
router.post('/:user', calendarController.postCalendarDocument);
router.put('/:user/:calendarDocId', calendarController.updateCalendarDocumentGivenId)
router.patch('/:user/updateDate/:calendarDocId', calendarController.updateCalendarDocumentDateGivenId);
router.patch('/:user/updateTake/:calendarDocId', calendarController.updateCalendarDocumentTakeGivenId);
router.delete('/:user/:calendarDocId', calendarController.deleteCalendarDocumentGivenId)

export default router;