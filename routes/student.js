const express = require("express");
const bodyParser = require("body-parser");
const pool = require("../data/dbConnection");
const util = require("util");
const fs = require("fs");
const mysql2Promise = require("mysql2/promise");
const path = require("path")
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


//the best one till now
router.get("/showCourse/:courseId", async (req, res) => {
  try {
    const query = util.promisify(pool.query).bind(pool);
    const courseId = req.params.courseId;

    // Get course data
    const courseSql = `SELECT * FROM course WHERE idcourse = ${courseId}`;
    const courseResult = await query(courseSql);
    if (courseResult.length === 0) {
      return res.status(404).json({ error: "Course not found" });
    }
    
    const course = courseResult[0];

    // Get sections data
    const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
    const sectionsResult = await query(sectionsSql);

    // Map over each section to get the content data
    const sectionsPromises = sectionsResult.map(async (section) => {
      const sectionId = section.idcourse_chapter;

      // Get content data
      const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
      const contentResult = await query(contentSql);

      // Update section object with content data
      section.content = contentResult[0];

      return section;
    });

    // Wait for all section promises to resolve
    const sections = await Promise.all(sectionsPromises);

    // Update course object with sections data
    course.sections = sections;

    res.json(course);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});


router.get('/files/:type/:id', (req, res) => {
  const type = req.params.type;
  const id = req.params.id;

  let table, column, folder, contentType;

  switch (type) {
    case '2':
      table = 'course_chpater_content';
      column = 'pathToContent';
      folder = 'photos';
      contentType = 'image/jpeg';
      break;
    case '4':
      table = 'course_chpater_content';
      column = 'pathToContent';
      folder = 'videos';
      contentType = 'video/mp4';
      break;
    case '1':
      table = 'course_chpater_content';
      column = 'pathToContent';
      folder = 'pdfs';
      contentType = 'application/pdf';
      break;
    default:
      res.sendStatus(404);
      return;
  }

  pool.query(`SELECT * FROM ${table} WHERE pathToContent = ?`, [id], (error, results, fields) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
      return;
    }

    if (results.length === 0) {
      res.sendStatus(404);
      return;
    }

    const filePath = `./uploads/${results[0][column]}`;
    const fileStream = fs.createReadStream(filePath);
    res.set('Content-Type', contentType);
    fileStream.pipe(res);
  });
});


// Define route to get course data
router.get('/showCourse/:courseId', async (req, res) => {
  try {
    const query = util.promisify(pool.query).bind(pool);
    const courseId = req.params.courseId;

    // Get course data
    const courseSql = `SELECT * FROM course WHERE idcourse = ${courseId}`;
    const courseResult = await query(courseSql);
    if (courseResult.length === 0) {
      return res.status(404).json({ error: "Course not found" });
    }
    
    const course = courseResult[0];

    // Get sections data
    const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
    const sectionsResult = await query(sectionsSql);

    // Map over each section to get the content data
    const sectionsPromises = sectionsResult.map(async (section) => {
      const sectionId = section.idcourse_chapter;

      // Get content data
      const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
      const contentResult = await query(contentSql);

      // Loop through all content results and add file data to the array
      for (let i = 0; i < contentResult.length; i++) {
        const filePath = contentResult[i].pathToContent;
        const fileData = fs.readFileSync(filePath);

        // Add file data to the content object
        contentResult[i].fileData = fileData;
      }

      // Update section object with content data
      section.content = contentResult;

      return section;
    });

    // Wait for all section promises to resolve
    const sections = await Promise.all(sectionsPromises);

    // Update course object with sections data
    course.sections = sections;

    res.json(course);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

















//this route uses params
const axios = require("axios");
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
// ...
// ...
// ...
//sent the data using request body 
router.post('/enroll', (req, res) => {
  const { student_id, course_id } = req.body;

  const enrollment = {
    student_id,
    course_id,
    enrollment_Date: new Date(),
    is_paid_subscription: 0
  };

  const query = 'INSERT INTO enrollment SET ?';

  pool.query(query, enrollment, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'An error occurred' });
    } else {
      const enrollmentId = result.insertId;
      res.json({ student_id, course_id, enrollmentId });
    }
  });
});

//sent the data using params 
router.get("/mycourses/:studentId", (req, res) => {
  const studentId = req.params.studentId;

  const query = `
    SELECT c.*
    FROM course c
    INNER JOIN enrollment e ON e.course_id = c.idcourse
    WHERE e.student_id = ?
  `;

  pool.query(query, [studentId], (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: "An error occurred" });
    } else {
      res.json(results);
    }
  });
});

router.post("/chooseInterests", async (req, res) => {
  const interests = req.body.interests;
  const studentId = req.body.student_id;

  try {
    const requestData = {
      interests: interests,
    };

    const response = await axios.post(
      "https://aeaa-159-223-191-226.ngrok-free.app/recommend",
      requestData
    );

    const recommendedCourses = Object.values(response.data);
    console.log(recommendedCourses);

    const insertPromises = recommendedCourses.map((course) => {
      const courseData = JSON.stringify(course);
      const sql =
        "INSERT INTO student_recommended_courses (studentId, CourseData) VALUES (?, ?) ON DUPLICATE KEY UPDATE studentId=studentId";
      return new Promise((resolve, reject) => {
        pool.query(sql, [studentId, courseData], (err, result) => {
          if (err) {
            reject(err);
          } else {
            resolve(result);
          }
        });
      });
    });

    Promise.all(insertPromises)
      .then(() => {
        console.log("Data inserted successfully");
        res.json(recommendedCourses);
      })
      .catch((error) => {
        console.error(error);
        res.status(500).json({ error: "Server error" });
      });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

// ...

// ...

// ...

// ...

router.get("/recommendedCourses/:studentId", async (req, res) => {
  try {
    const studentId = req.params.studentId;
    const query = util.promisify(pool.query).bind(pool);

    const sql = `SELECT CourseData FROM student_recommended_courses WHERE studentId = ${studentId}`;
    const courses = await query(sql);

    res.json(courses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Server error" });
  }
});

// ...

module.exports = router;
