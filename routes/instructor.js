const express = require("express");
const bodyParser = require("body-parser");
const multer = require("multer");
const fs = require("fs");
const path = require("path");

const instructorController = require("../controllers/instructorController");
const instructorIsAuth = require("../middlewares/instructorIsAuth");

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));
router.use(express.json());
const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: function (req, file, cb) {
    // Generate a unique ID for the file
    const uniqueId = Date.now().toString();
    // Extract the file extension
    const ext = path.extname(file.originalname);
    // Set the file name to be the unique ID with the original extension
    const fileName = uniqueId + ext;
    // Pass the generated file name to the callback function
    cb(null, fileName);
  },
});

const upload = multer({ storage: storage });

const pool = require("../data/dbConnection");

router.get(
  "/instructorHomeProfile/:id",
  instructorController.instructorHomeProfile
);
router.post("/editAccountInfo", instructorController.editAccountInfo);

router.get("/instructorProfile/:userId", (req, res) => {
  //replace req.body.course_title with the request data that is comming from flutter in the search input

  const userId = req.params.userId;
  const sql = `select * from instructor where idinstructor = ${userId};`;
  pool.query(sql, (err, result) => {
    if (err) throw err;
    else {
      console.log(result[0]);
      res.json(result[0]);
    }
  });
});
// Add a course
router.post("/instructors/:instructorId/courses", (req, res) => {
  const {
    course_title,
    course_brief,
    num_of_chapters,
    course_fee,
  } = req.body;
  
  const instructorId = req.params.instructorId;

  const course = {
    course_title,
    course_brief,
    num_of_chapters,
    course_fee,
    instructor_id: instructorId,
  };
  console.log(course);

  // First, check if the specified instructor exists
  pool.query("SELECT * FROM instructor WHERE idInstructor = ?", [instructorId], (err, rows) => {
    if (err) {
      console.error("Error retrieving instructor:", err);
      res.status(500).json({ error: "Failed to retrieve instructor" });
      return;
    }

    if (rows.length === 0) {
      // The specified instructor doesn't exist
      res.status(404).json({ error: "Instructor not found" });
      return;
    }

    // The specified instructor exists, proceed to add the course
    pool.query("INSERT INTO course SET ?", course, (err, result) => {
      if (err) {
        console.error("Error adding the course:", err);
        res.status(500).json({ error: "Failed to add the course" });
        return;
      }
      console.log("Course added successfully");
      res.status(201).json({ message: "Course added successfully" });
    });
  });
});


// Add a section to a course
router.post("/courses/:courseId/sections", (req, res) => {
  const courseId = req.params.courseId;
  const {
    chapter_title,
    num_of_reading,
    num_of_video,
    num_of_assignment,
    num_of_ar_content,
  } = req.body;

  const section = {
    chapter_title,
    num_of_reading,
    num_of_video,
    num_of_assignment,
    num_of_ar_content,
    course_idcourse: courseId,
  };

  pool.query("INSERT INTO course_chapter SET ?", section, (err, result) => {
    if (err) {
      console.error("Error adding the section:", err);
      res.status(500).json({ error: "Failed to add the section" });
      return;
    }
    console.log("Section added successfully");
    res.status(201).json({ message: "Section added successfully" });
  });
});

router.post('/sections/:sectionId/content', upload.single('file'), (req, res) => {
  const file = req.file;
  const sectionId = req.params.sectionId;

  const {
    is_mandatory,
    time_required_in_sec,
    is_open_for_free,
    content_type_idcontent_type,
  } = req.body;

  const content = {
    is_mandatory,
    time_required_in_sec,
    is_open_for_free,
    course_chapter_idcourse_chapter: sectionId,
    content_type_idcontent_type,
    pathToContent: file.filename,
    contentItself: null,
  };

  pool.query('INSERT INTO course_chpater_content SET ?', content, (err, result) => {
    if (err) {
      console.error('Error adding the content:', err);
      res.status(500).json({ error: 'Failed to add the content' });
      return;
    }
    console.log('Content added successfully');
    res.status(201).json({ message: 'Content added successfully' });
  });
});

// Search course by name
router.get("/courses/search/:courseName", (req, res) => {
  const courseName = req.params.courseName;
  const sql = `SELECT * FROM course WHERE course_title LIKE '%${courseName}%';`;
  pool.query(sql, (err, result) => {
    if (err) {
      console.error("Error searching for courses:", err);
      res.status(500).json({ error: "Failed to search for courses" });
      return;
    }
    console.log("Courses found:", result);
    res.json(result);
  });
});

//search instructor courses
router.get("/instructorCourses/:userId/search", (req, res) => {
  const userId = req.params.userId;
  const courseName = req.query.courseName;
  console.log(courseName);
  const sql = `
    SELECT c.*
    FROM instructor AS i
    JOIN course AS c ON i.idinstructor = c.instructor_id
    WHERE i.idinstructor = ${userId}
    AND c.course_title LIKE '%${courseName}%';
  `;

  pool.query(sql, (err, result) => {
    if (err) {
      console.error("Error searching for instructor courses:", err);
      res
        .status(500)
        .json({ error: "Failed to search for instructor courses" });
      return;
    }
    console.log("Instructor courses found:", result);
    res.json(result);
  });
});

// Edit a course details
router.put("/courses/:courseId", (req, res) => {
  const courseId = req.params.courseId;
  const {
    course_title,
    course_brief,
    num_of_chapters,
    course_fee,
    instructor_id,
  } = req.body;

  const updatedCourse = {
    course_title,
    course_brief,
    num_of_chapters,
    course_fee,
    instructor_id,
  };

  pool.query(
    "UPDATE course SET ? WHERE idcourse = ?",
    [updatedCourse, courseId],
    (err, result) => {
      if (err) {
        console.error("Error updating the course:", err);
        res.status(500).json({ error: "Failed to update the course" });
        return;
      }
      console.log("Course updated successfully");
      res.status(200).json({ message: "Course updated successfully" });
    }
  );
});

module.exports = router;
