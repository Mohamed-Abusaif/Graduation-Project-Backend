const mysql = require("mysql2");

const pool = mysql.createPool({
  connectionLimit: 100, //important
  port: 3306,
  user: "root",
  password: "root",
  database: "courseschemagp",
});


// pool.query("SELECT * FROM student",(err, data) => {
//     if(err) {
//         console.error(err);
//         return;
//     }
//     // rows fetch
//     console.log("database connected");
// });

pool.getConnection((err)=>{
if(err) throw err
else console.log("database connected!")
})

module.exports = pool;