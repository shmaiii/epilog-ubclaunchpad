const express = require('express')
const router = express.Router();

router.route("/entries").get(list_all)
module.exports = router;