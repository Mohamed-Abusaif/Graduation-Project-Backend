const express = require("express");
const bodyParser = require("body-parser");
const instructorController = require("../controllers/instructorController");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

const pool = require("../data/dbConnection");

router.post("/instructorSignUp");



router.get(
  "/studentsEnrolledInInstCourse",
  instructorController.studentsEnrolledInInstCourse
);
router.get(
  "/showInstructorCourses",
  instructorController.showInstructorCourses
);
router.get("/showAccountInfo", instructorController.showAccountInfo);
router.post("/editAccountInfo", instructorController.editAccountInfo);

module.exports = router;
