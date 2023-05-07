const path = require("path");

exports.getHomePage = (req, res, nxt) => {
  res.render("../views/home/index.ejs", {
    pageTitle: "Home Page!",
    path: "/"
  });
};
