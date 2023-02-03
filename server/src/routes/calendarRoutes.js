import express from 'express'

import getAllCalendarDocumentsFromUser from '../controllers/calendarController.js'

const router = express.Router()

router.get('/:user', getAllCalendarDocumentsFromUser.getAllCalendarDocumentsGivenUser)
router.get('/:user/:id', getAllCalendarDocumentsFromUser.getCalendarDocumentGivenId)


export default router