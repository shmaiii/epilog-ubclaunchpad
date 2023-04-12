import express from 'express';

import contactsController from '../controllers/contactsController.js';

const router = express.Router();

router.get('/read', contactsController.getContacts);
router.post('/add', contactsController.addContact);
router.post('/:cid/edit', contactsController.editContact);
router.post('/:cid/delete', contactsController.deleteContact);

export default router;