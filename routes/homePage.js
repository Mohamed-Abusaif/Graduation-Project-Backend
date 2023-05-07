const express = require("express")
const router = express.Router();
const HomeController = require("../controllers/HomeController");


// const isAuth = require('../middlewares/isAuth')

router.get("/", HomeController.getHomePage);

router.get("/about" , (req,res)=>{
    res.render("../views/home/about.ejs")
});

router.get("/contact" , (req,res)=>{
    res.render("../views/home/contact.ejs")
});
router.get("/course" , (req,res)=>{
    res.render("../views/home/course.ejs")
});


module.exports = router;