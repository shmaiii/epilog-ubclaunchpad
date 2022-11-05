const express = require('express')
const router = express.Router();
const {list_all, create} = require("../controller/entriesController")

router.route("/all").get(list_all)
router.route("/create").post(create)
module.exports = router;