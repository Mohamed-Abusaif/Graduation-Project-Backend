const express = require("express");
const bodyParser = require("body-parser");
const pool = require("../data/dbConnection");
const util = require("util");
const fs = require("fs");

const studentController = require("../controllers/studentController");
const studentIsAuth = require("../middlewares/studentIsAuth");

const router = express.Router();
router.use(express.json());

router.use(bodyParser.urlencoded({ extended: false }));
// ...

router.get("/showCourses", async (req, res) => {
  try {
    const query = util.promisify(pool.query).bind(pool);

    const sql = `SELECT * FROM course`;
    const courses = await query(sql);

    const coursePromises = courses.map(async (course) => {
      const courseId = course.idcourse;

      const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
      const sections = await query(sectionsSql);

      const sectionsPromises = sections.map(async (section) => {
        const sectionId = section.idcourse_chapter;

        const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
        const content = await query(contentSql);

        section.content = content;
        return section;
      });

      course.sections = await Promise.all(sectionsPromises);
      return course;
    });

    const coursesWithSectionsAndContent = await Promise.all(coursePromises);

    res.json(coursesWithSectionsAndContent);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

router.get("/showCourse/:courseId", async (req, res) => {
  try {
    const query = util.promisify(pool.query).bind(pool);
    const courseId = req.params.courseId;

    const courseSql = `SELECT * FROM course WHERE idcourse = ${courseId}`;
    const courseResult = await query(courseSql);
    const course = courseResult[0];

    const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
    const sectionsResult = await query(sectionsSql);

    const sectionsPromises = sectionsResult.map(async (section) => {
      const sectionId = section.idcourse_chapter;

      const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
      const contentResult = await query(contentSql);

      const contentPromises = contentResult.map(async (content) => {
        const binaryContent = content.contentItself;
        const filePath = `../pathToSaveFile/`; // Specify the file path where you want to save the content

        // Write the binary content to a file
        fs.writeFileSync(filePath, binaryContent);

        // Update the content object with the file path or any other necessary transformation
        content.filePath = filePath;

        return content;
      });

      section.content = await Promise.all(contentPromises);
      return section;
    });

    course.sections = await Promise.all(sectionsPromises);

    res.json(course);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
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
//recommendation system
router.post("/chooseInterests", async (req, res) => {
  const interests = req.body.interests;
  const student_id = req.body.student_id;

  for (let i = 0; i < interests.length; i++) {
    const sql = `INSERT INTO interests (intrests, student_id) VALUES (?, ?)`;
    pool.query(sql, [interests[i], student_id], (err, result) => {
      if (err) throw err;
      else {
        console.log("Data inserted successfully");
      }
    });
  }

  const requestData = {
    interests: interests,
  };

  try {
    const response = await axios.post(
      "https://36bf-197-62-29-20.ngrok-free.app/recommend",
      requestData
    );
    console.log("Recommendation system response:", response.data);

    const recommendedCourses = response.data;
    const courses = [];
    for (const courseId in recommendedCourses) {
      const courseName = recommendedCourses[courseId];
      const university = recommendedCourses[courseId];
      const course = {
        id: courseId,
        name: courseName,
        university: university,
      };
      courses.push(course);
    }
    res.json(courses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

module.exports = router;
