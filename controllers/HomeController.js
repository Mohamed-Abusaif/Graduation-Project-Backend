const path = require("path");

exports.getHomePage = (req, res, nxt) => {
  res.render("home.ejs", {
    pageTitle: "Home Page!",
    path: "/"
  });
};
