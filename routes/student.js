const express = require("express");
const bodyParser = require("body-parser");
const pool = require("../data/dbConnection");
const util = require("util");
const fs = require("fs");
const mysql2Promise = require("mysql2/promise");

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

// router.get("/showCourse/:courseId", async (req, res) => {
//   try {
//     const query = util.promisify(pool.query).bind(pool);
//     const courseId = req.params.courseId;

//     const courseSql = `SELECT * FROM course WHERE idcourse = ${courseId}`;
//     const courseResult = await query(courseSql);
//     const course = courseResult[0];

//     const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
//     const sectionsResult = await query(sectionsSql);

//     const sectionsPromises = sectionsResult.map(async (section) => {
//       const sectionId = section.idcourse_chapter;

//       const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
//       const contentResult = await query(contentSql);

//       const contentPromises = contentResult.map(async (content) => {
//         const binaryContent = content.contentItself;
//         const filePath = `../pathToSaveFile/`; // Specify the file path where you want to save the content

//         // Write the binary content to a file
//         fs.writeFileSync(filePath, binaryContent);

//         // Update the content object with the file path or any other necessary transformation
//         content.filePath = filePath;

//         return content;
//       });

//       section.content = await Promise.all(contentPromises);
//       return section;
//     });

//     course.sections = await Promise.all(sectionsPromises);

//     res.json(course);
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ error: "Server error" });
//   }
// });

router.get("/showCourse/:courseId", (req, res) => {
  const courseId = req.params.courseId;

  const courseSql = `SELECT * FROM course WHERE idcourse = ${courseId}`;
  const courseQuery = new Promise((resolve, reject) => {
    pool.query(courseSql, (error, courseResult) => {
      if (error) {
        reject(error);
      } else {
        resolve(courseResult);
      }
    });
  });

  courseQuery
    .then((courseResult) => {
      const course = courseResult[0];

      const sectionsSql = `SELECT * FROM course_chapter WHERE course_idcourse = ${courseId}`;
      const sectionsQuery = new Promise((resolve, reject) => {
        pool.query(sectionsSql, (error, sectionsResult) => {
          if (error) {
            reject(error);
          } else {
            resolve(sectionsResult);
          }
        });
      });

      sectionsQuery
        .then((sectionsResult) => {
          const sections = sectionsResult;

          const sectionsPromises = sections.map((section) => {
            const sectionId = section.idcourse_chapter;

            const contentSql = `SELECT * FROM course_chpater_content WHERE course_chapter_idcourse_chapter = ${sectionId}`;
            const contentQuery = new Promise((resolve, reject) => {
              pool.query(contentSql, (error, contentResult) => {
                if (error) {
                  reject(error);
                } else {
                  resolve(contentResult);
                }
              });
            });

            return contentQuery.then((contentResult) => {
              const content = contentResult[0];
              section.content = content;
              return section;
            });
          });

          Promise.all(sectionsPromises)
            .then((sectionsWithContent) => {
              course.sections = sectionsWithContent;
              res.json(course);
            })
            .catch((error) => {
              console.error(error);
              res.status(500).json({ error: "Server error" });
            });
        })
        .catch((error) => {
          console.error(error);
          res.status(500).json({ error: "Server error" });
        });
    })
    .catch((error) => {
      console.error(error);
      res.status(500).json({ error: "Server error" });
    });
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
