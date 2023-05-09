const express = require("express");
const bodyParser = require("body-parser");
const pool = require("../data/dbConnection");

const studentController = require("../controllers/studentController");
const studentIsAuth = require("../middlewares/studentIsAuth");

const router = express.Router();
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

router.get("/recommendations", async (req, res) => {
  try {
    //the data now is hard coded you need to provide some variable to store the data comming from flutter and convert it into json format

    const requestData = {
      interests: ["C++", "anatomy", "machine learning"],
    };

    const response = await axios.post(
      "https://ad87-102-44-82-83.ngrok-free.app/recommend",
      requestData
    );
    console.log("hello from recommendation system api");

    const data = response.data;

    res.json(data);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Server error" });
  }
});

router.get("/searchCourses", (req, res) => {
  //replace req.body.course_title with the request data that is comming from flutter in the search input
  const courseName = req.body.course_title;
  const sql = `SELECT * FROM course WHERE course_title LIKE '%${courseName}%'`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else {
      console.log(result);
      res.send("Your search query!");
    }
  });
});

router.get("/studentProfile/:userId", (req, res) => {
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



module.exports = router;
