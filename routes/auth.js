const express = require("express");
const pool = require("../data/dbConnection");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));
router.use(express.json());
const authController = require("../controllers/authController");


// Student registration
router.post("/students/register", authController.studentRegister);
// Student login
router.post("/students/login", authController.studentLogin);

// Instructor registration
router.post("/instructors/register",authController.instructorRegister );
// Instructor login
router.post("/instructors/login", authController.instructorLogin);


module.exports = router;
