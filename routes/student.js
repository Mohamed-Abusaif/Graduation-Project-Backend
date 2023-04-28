const express = require("express");
const bodyParser = require("body-parser");

const studentController = require("../controllers/studentController");
const studentIsAuth = require("../middlewares/studentIsAuth");

const router = express.Router();
router.use(bodyParser.urlencoded({ extended: false }));

