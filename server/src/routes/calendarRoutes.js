import express from 'express';

import calendarController from '../controllers/calendarController.js';

const router = express.Router();

router.get('/:user', calendarController.getAllCalendarDocumentsGivenUser);
router.get('/:user/:id', calendarController.getCalendarDocumentGivenId);
router.post('/', calendarController.postCalendarDocument);

export default router;
