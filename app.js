const express = require("express");
const path = require("path");
const session = require("express-session");
const bodyParser = require("body-parser");
const mysqlStore = require("express-mysql-session")(session);

const db = require("./data/dbConnection");
const homeRoute = require("./routes/homePage");
const instructorRoute = require("./routes/instructor");
const studentRoute = require("./routes/student");
const authRoute = require("./routes/auth");
const app = express();

app.use(studentRoute);
app.use(instructorRoute);
app.use(homeRoute);
app.use(authRoute);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));
app.use(
  session({
    secret: "My Secret Example",
    resave: false,
    saveUninitialized: false,
  })
);
app.set("view engine", "ejs");
app.set("views", "views");

const port = 3003;
app.listen(port, () => {
  console.log(`Server Is Running On Port ${port}!`);
});
