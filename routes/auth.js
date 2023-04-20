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

router.post("/studentLogin", (req, res) => {
  const userEmail = req.body.userEmail;
  const userPassword = req.body.userPassword;
  const sql = `select * from student where email = '${userEmail}';`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    return result;
  });
  res.redirect("/");
});
router.post("/instructorLogin", (req, res) => {});

router.post("/studentRegister", authController.studentRegister);
router.post("/instructorRegister", authController.instructorRegister);

module.exports = router;
