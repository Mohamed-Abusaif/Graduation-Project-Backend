const express = require("express");
const bodyParser = require("body-parser");
const instructorController = require("../controllers/instructorController");
const instructorIsAuth = require("../middlewares/instructorIsAuth");

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));
const pool = require("../data/dbConnection");




router.get(
  "/instructorHomeProfile/:id",
  instructorController.instructorHomeProfile
);
router.post(
  "/editAccountInfo",
  instructorController.editAccountInfo
);

router.get("")

module.exports = router;
