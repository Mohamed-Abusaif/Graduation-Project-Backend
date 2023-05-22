//don't forget to add the following in signup functionallity:
//hashing password using bcrypt
//adding the time the users registered

const express = require("express");
const pool = require("../data/dbConnection");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

exports.studentRegister = (req, res) => {
  // Retrieve student registration data from the request body
  const { email, password, first_name, last_name } = req.body;

  // Hash the password
  bcrypt.hash(password, 10, (err, hashedPassword) => {
    if (err) {
      console.error("Error hashing password:", err);
      res.status(500).json({ error: "Failed to register student" });
      return;
    }

    // Save the student to the database with the hashed password
    const student = {
      email,
      password: hashedPassword,
      first_name,
      last_name,
    };

    // Save the student to the database
    pool.query("INSERT INTO student SET ?", student, (err, result) => {
      if (err) {
        console.error("Error saving student:", err);
        res.status(500).json({ error: "Failed to register student" });
        return;
      }

      // Retrieve the inserted student_id
      const studentId = result.insertId;

      // Generate a JWT token for the student
      const token = jwt.sign(
        { studentId, role: "student" }, // Include studentId in the token payload
        "secret-key",
        { expiresIn: "1h" }
      );

      res.status(201).json({
        message: "Student registered successfully",
        token,
        student_id: studentId, // Include student_id in the response
      });
    });
  });
};

exports.studentLogin = (req, res) => {
  // Retrieve student login data from the request body
  const { email, password } = req.body;

  // Find the student in the database by email
  pool.query("SELECT * FROM student WHERE email = ?", email, (err, results) => {
    if (err) {
      console.error("Error retrieving student:", err);
      res.status(500).json({ error: "Failed to login" });
      return;
    }

    // Check if a student with the provided email exists in the database
    if (results.length === 0) {
      res.status(401).json({ error: "Invalid email or password" });
      return;
    }

    // Retrieve the student's data from the database
    const student = results[0];

    // Compare the provided password with the stored hashed password
    bcrypt.compare(password, student.password, (err, result) => {
      if (err || !result) {
        // Invalid credentials
        res.status(401).json({ error: "Invalid email or password" });
        return;
      }

      // Generate a JWT token for the student
      const token = jwt.sign(
        { studentId: student.id, role: "student" }, // Include studentId in the token payload
        "secret-key",
        { expiresIn: "1h" }
      );

      res.status(200).json({
        message: "Student logged in successfully",
        token,
        student_id: student.idstudent, // Include student_id in the response
      });
    });
  });
};

exports.instructorRegister = (req, res) => {
  // Retrieve instructor registration data from the request body
  const { email, password, first_name, last_name } = req.body;

  // Hash the password
  bcrypt.hash(password, 10, (err, hashedPassword) => {
    if (err) {
      console.error("Error hashing password:", err);
      res.status(500).json({ error: "Failed to register instructor" });
      return;
    }

    // Save the instructor to the database with the hashed password
    const instructor = {
      email,
      password: hashedPassword,
      first_name,
      last_name,
    };

    // Save the instructor to the database
    pool.query("INSERT INTO instructor SET ?", instructor, (err, result) => {
      if (err) {
        console.error("Error saving instructor:", err);
        res.status(500).json({ error: "Failed to register instructor" });
        return;
      }

      // Retrieve the inserted instructor_id
      const instructorId = result.insertId;

      // Generate a JWT token for the instructor
      const token = jwt.sign(
        { instructorId, role: "instructor" }, // Include instructorId in the token payload
        "secret-key",
        { expiresIn: "1h" }
      );

      res.status(201).json({
        message: "Instructor registered successfully",
        token,
        instructor_id: instructorId, // Include instructor_id in the response
      });
    });
  });
};
exports.instructorLogin = (req, res) => {
  // Retrieve instructor login data from the request body
  const { email, password } = req.body;

  // Find the instructor in the database by email
  pool.query(
    "SELECT * FROM instructor WHERE email = ?",
    email,
    (err, results) => {
      if (err) {
        console.error("Error retrieving instructor:", err);
        res.status(500).json({ error: "Failed to login" });
        return;
      }

      // Check if an instructor with the provided email exists in the database
      if (results.length === 0) {
        res.status(401).json({ error: "Invalid email or password" });
        return;
      }

      // Retrieve the instructor's data from the database
      const instructor = results[0];

      // Compare the provided password with the stored hashed password
      bcrypt.compare(password, instructor.password, (err, result) => {
        if (err || !result) {
          // Invalid credentials
          res.status(401).json({ error: "Invalid email or password" });
          return;
        }

        // Generate a JWT token for the instructor
        const token = jwt.sign(
          { instructorId: instructor.id, role: "instructor" }, // Include instructorId in the token payload
          "secret-key",
          { expiresIn: "1h" }
        );

        res.status(200).json({
          message: "Instructor logged in successfully",
          token,
          instructor_id: instructor.idinstructor, // Include instructor_id in the response
        });
      });
    }
  );
};
