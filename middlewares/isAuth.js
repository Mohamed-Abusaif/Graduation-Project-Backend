module.exports = (req,res,next)=>{
    if(!req.sesstion.isLoggedIn){
        return res.redirect('/login')
    }
    next();
}
