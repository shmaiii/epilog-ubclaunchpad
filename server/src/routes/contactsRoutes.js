import express from 'express';

import contactsController from '../controllers/contactsController.js';

const router = express.Router();

router.get('/user/:id/contacts/read', contactsController.getContacts);
router.post('/user/:id/contacts/add', contactsController.addContact);
router.post('/user/:uid/contacts/:cid/edit', contactsController.editContact);
router.post('/user/:uid/contacts/:cid/delete', contactsController.deleteContact);

export default router;