module.exports = (req,res,next)=>{
    if(!req.session.studentIsLoggedIn){
        return res.redirect('/login')
    }
    next();
}
