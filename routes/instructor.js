const express = require("express");
const bodyParser = require("body-parser");
const instructorController = require("../controllers/instructorController");
const instructorIsAuth = require("../middlewares/instructorIsAuth");

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));
const pool = require("../data/dbConnection");

router.post("/instructorSignUp");

router.get(
  "/studentsEnrolledInInstCourse",
  instructorIsAuth,
  instructorController.studentsEnrolledInInstCourse
);
router.get(
  "/showInstructorCourses",
  instructorIsAuth,
  instructorController.showInstructorCourses
);
router.get(
  "/showAccountInfo",
  instructorIsAuth,
  instructorController.showAccountInfo
);
router.post(
  "/editAccountInfo",
  instructorIsAuth,
  instructorController.editAccountInfo
);

module.exports = router;
