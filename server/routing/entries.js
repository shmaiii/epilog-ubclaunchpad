import express from 'express';
import {list_all, create, update} from "../controller/entriesController.js";

const router = express.Router();

router.route("/all").get(list_all)
router.route("/create").post(create)
router.route("").put(update)
export {router}