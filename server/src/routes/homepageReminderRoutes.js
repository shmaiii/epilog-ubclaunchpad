import express from 'express';

import homepageReminderController from '../controllers/homepageReminderController.js';

const router = express.Router();

router.get('/:user', homepageReminderController.getAllReminderDocuments);
//router.get('/:user/:reminderDocId', homepageReminderController.deleteHomepageReminderDocumentGivenId);

export default router;
