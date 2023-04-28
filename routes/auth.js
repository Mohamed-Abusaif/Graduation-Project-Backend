const express = require("express");
const pool = require("../data/dbConnection");
const bodyParser = require("body-parser");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

const authController = require("../controllers/authController");

router.get("/studentLogin", authController.getStudentLoginForm);
router.get("/instructorLogin", authController.getInstructorLoginForm);
router.get("/studentRegister", authController.getStudentSignupForm);
router.get("/instructorRegister", authController.getInstructorSingupForm);

const session = require("express-session");

router.use(
  session({
    secret: "your-secret-key",
    resave: false,
    saveUninitialized: false,
  })
);

router.post("/studentLogin", authController.studentLogin);
router.post("/instructorLogin", authController.instructorLogin);

router.post("/studentRegister", authController.studentRegister);
router.post("/instructorRegister", authController.instructorRegister);

module.exports = router;
