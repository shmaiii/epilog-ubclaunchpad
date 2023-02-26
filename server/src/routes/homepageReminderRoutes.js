import express from 'express';

import homepageReminderController from '../controllers/homepageReminderController.js';

const router = express.Router();

router.get('/:user', homepageReminderController.getAllReminderDocuments);
router.patch('/:user/update/:reminderDocId', homepageReminderController.updateHomepageReminderGivenId);
router.delete('/:user/delete/:reminderDocId', homepageReminderController.deleteHomepageReminderDocumentGivenId);

export default router;
