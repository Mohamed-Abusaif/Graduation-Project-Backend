const express = require("express");
const bodyParser = require("body-parser");
const pool = require("../data/dbConnection");

const studentController = require("../controllers/studentController");
const studentIsAuth = require("../middlewares/studentIsAuth");

const router = express.Router();
router.use(express.json());

router.use(bodyParser.urlencoded({ extended: false }));

router.get("/showCourses", (req, res) => {
  const sql = `select * from course`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else console.log(result);
    res.send("data is back");
  });
});

const axios = require("axios");

//this route uses params
router.get("/searchCourses/:course_title", (req, res) => {
  //replace req.body.course_title with the request data that is comming from flutter in the search input
  const courseName = req.params.course_title;
  const sql = `SELECT * FROM course WHERE course_title LIKE '%${courseName}%'`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else {
      console.log(result);
      res.send("Your search query!");
    }
  });
});
//this route uses params
router.get("/studentProfile/:userId", (req, res) => {
  //replace req.body.course_title with the request data that is comming from flutter in the search input

  const userId = req.params.userId;
  const sql = `select * from student where idstudent = ${userId};`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else {
      console.log(result[0]);
      res.json(result[0]);
    }
  });
});
//this route uses params
router.get("/studentInterests/:studentId", (req, res) => {
  //replace req.body.course_title with the request data that is comming from flutter in the search input

  const studentId = req.params.studentId;

  const sql = `select * from interests where student_Id = ${studentId};`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else {
      console.log(result);
      res.json(result);
    }
  });
});

router.post("/chooseInterests", async (req, res) => {
  const interests = req.query.interests.split(",");
  const student_id = req.query.student_id;

  for (let i = 0; i < interests.length; i++) {
    const sql = `insert into interests (intrests,student_id) values (?,?)`;
    pool.query(sql, [interests[i], student_id], (err, result) => {
      if (err) throw err;
      else {
        console.log("data Inserted successfully");
      }
    });
  }

  const requestData = {
    interests: interests,
  };

  try {
    const response = await axios.post(
      "https://ad87-102-44-82-83.ngrok-free.app/recommend",
      requestData
    );
    console.log("Recommendation system response:", response.data);

    const recommendedCourses = response.data; // Store the recommended courses in an array
    // res.json(recommendedCourses); // Return the array as the response from the API
    const courses = [];
    for (const courseId in recommendedCourses["Course Name"]) {
      const courseName = recommendedCourses["Course Name"][courseId];
      const university = recommendedCourses["Course Name"][courseId];
      const course = {
        id: courseId,
        name: courseName,
        university: university,
      };
      courses.push(course);
    }
    res.json(courses); //return it as an array of json objects (be carefull may cause an error in flutter application)
    
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
