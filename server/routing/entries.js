import express from 'express';
import {list_all, create} from "../controller/entriesController.js";

const router = express.Router();

router.route("/all").get(list_all)
router.route("/create").post(create)
export {router}