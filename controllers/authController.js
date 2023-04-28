//don't forget to add the following in signup functionallity:
//hashing password using bcrypt
//adding the time the users registered

const express = require("express");
const pool = require("../data/dbConnection");
const bodyParser = require("body-parser");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

exports.getStudentLoginForm = (req, res) => {
  res.render("auth/studentLogin.ejs", {
    pageTitle: "Login as Student!",
  });
};

exports.getInstructorLoginForm = (req, res) => {
  res.render("auth/instructorLogin.ejs", {
    pageTitle: "Login as Instructor!",
  });
};

exports.getStudentSignupForm = (req, res) => {
  res.render("auth/studentRegister.ejs", {
    pageTitle: "Sign Up as Student!",
  });
};

exports.getInstructorSingupForm = (req, res) => {
  res.render("auth/instructorRegister.ejs", {
    pageTitle: "Sign Up as Instructor!",
  });
};

exports.studentRegister = (req, res) => {
  const firstName = req.body.first_name;
  const lastName = req.body.last_name;
  const userEmail = req.body.userEmail;
  const userPassword = req.body.userPassword;
  const confirmPassword = req.body.confirmPassword;

  const sql = `select * from student where email = '${userEmail}';`;
  pool.query(sql, (err, result) => {
    if (err) {
      throw err;
    } else {
      console.log(result);
      if (result.length >= 1) {
        console.error("user exists");
      } else {
        console.log("now we can add the user");
        if (userPassword !== confirmPassword) {
          console.log("the two passwords not matching");
        } else {
          const sql = `insert into student (first_name , last_name , email , password) 
          values ('${firstName}' , '${lastName}' , '${userEmail}' , '${userPassword}');`;
          pool.query(sql, (err, result) => {
            if (err) {
              throw err;
            } else {
              console.log("user inserted successfully!");
            }
          });
        }
      }
    }
  });

  res.redirect("/studentLogin");
};

exports.instructorRegister = (req, res) => {
  const firstName = req.body.first_name;
  const lastName = req.body.last_name;
  const userEmail = req.body.userEmail;
  const userPassword = req.body.userPassword;
  const confirmPassword = req.body.confirmPassword;

  const sql = `select * from instructor where email = '${userEmail}';`;
  pool.query(sql, (err, result) => {
    if (err) {
      throw err;
    } else {
      console.log(result);
      if (result.length >= 1) {
        console.error("user exists");
      } else {
        console.log("now we can add the user");
        if (userPassword !== confirmPassword) {
          console.log("the two passwords not matching");
        } else {
          const sql = `insert into instructor (first_name , last_name , email , password) 
          values ('${firstName}' , '${lastName}' , '${userEmail}' , '${userPassword}');`;
          pool.query(sql, (err, result) => {
            if (err) {
              throw err;
            } else {
              console.log("user inserted successfully!");
            }
          });
        }
      }
    }
  });

  res.redirect("/instructorLogin");
};

exports.studentLogin = (req, res) => {
  const userEmail = req.body.userEmail;
  const userPassword = req.body.userPassword;
  const sql = `select * from student where email = '${userEmail}';`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    if (result[0].password === userPassword) {
      // Set up session for logged-in user
      req.session.userId = result[0].id;
      req.session.studentIsLoggedIn = true;
      console.log("user Exists and now logged in successfully!");
      res.redirect("/");
    } else {
      console.log("passowrd is wrong");
      res.redirect("/studentLogin");
    }
  });
};

exports.instructorLogin = (req, res) => {
  const userEmail = req.body.userEmail;
  const userPassword = req.body.userPassword;
  const sql = `select * from instructor where email = '${userEmail}';`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
    if (result[0].password === userPassword) {
      // Set up session for logged-in user
      req.session.userId = result[0].id;
      req.session.instructorIsLoggedIn = true;
      console.log("user Exists and now logged in successfully!");
      res.redirect("/");
    } else {
      console.log("passowrd is wrong");
      res.redirect("/");
    }
  });
};
