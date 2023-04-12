const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const db = require("./data/dbConnection");
const homeRoute = require("./routes/homePage");
const instructorRoute = require("./routes/instructor");
const authRoute = require("./routes/auth");
const app = express();

app.use(instructorRoute);
app.use(homeRoute);
app.use(authRoute);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));
app.set("view engine", "ejs");
app.set("views", "views");

const port = 3000;
app.listen(port, () => {
  console.log(`Server Is Running On Port ${port}!`);
});
