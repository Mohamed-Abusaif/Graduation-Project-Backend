const express = require("express");
const bodyParser = require("body-parser");
const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

const pool = require("../data/dbConnection");

//req.body is the data comming from the form in any view in flutter

exports.showInstructorCourses = (req, res) => {
  const instructor_id = req.body.id; //will be replaced with req.user.id after adding authentication
  console.log(req.body.id);
  const sql = `select * from course where instructor_id = ${instructor_id} ;`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res.status(200).send("This is the showInstructorCourses");
};

exports.showAccountInfo = (req, res) => {
  const instructor_id = req.body.id; //will be replaced with req.user.id after adding authentication
  console.log(instructor_id);
  const sql = `select * from instructor where idinstructor=${instructor_id}`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res.status(200).send("this is show accound info");
};

exports.editAccountInfo = (req, res) => {
  const { field, value } = req.body;
  const userId = req.user.id; // Assuming you're using a user authentication system
  const sql = `UPDATE users SET ${field}=${value} WHERE id=${userId}`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
};

//leave it for now
exports.studentsEnrolledInInstCourse = (req, res) => {
  const course_name = req.body.course_name;
  const instructor_id = req.body.idinstructor;
  const sql = `SELECT s.*
FROM student s
INNER JOIN enrollment e ON s.idstudent = e.idenrollment
INNER JOIN course c ON e.course_id = c.idcourse
INNER JOIN instructor i ON e.instructor_id = i.idinstructor
WHERE c.course_title = ${course_name}
AND i.idinstructor = ${instructor_id};
`;

  pool.query(sql, (err, result) => {
    if (err) throw err;
    console.log(result);
  });
  res
    .status(200)
    .send(
      "this is students enrolled in specific course for specific instructor"
    );
};
