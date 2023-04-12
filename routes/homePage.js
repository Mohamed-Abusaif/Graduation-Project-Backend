const express = require("express")
const router = express.Router();
const HomeController = require("../controllers/HomeController");


// const isAuth = require('../middlewares/isAuth')

router.get("/", HomeController.getHomePage);


module.exports = router;