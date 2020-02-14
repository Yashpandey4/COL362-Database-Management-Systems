var express = require('express');
// for mailing
var path = require('path');
var bodyParser = require('body-parser');
var logger = require('morgan');
var app = require('./ApplicationInstance');
var flash    = require('connect-flash');
var cookieParser = require('cookie-parser');
var session      = require('express-session');
var compression = require('compression');
var _ = require("underscore");
var bcrypt = require('bcrypt-nodejs');
var salt = bcrypt.genSaltSync(10);
var passport = require('passport')

var mainRoutes = require('./backend/routes/MainRoutes');
//====== db require files ==========
// var connection = require('./config');
var connection = require('./backend/Models/db_connect.js');


//configuration for server ===============================================

app.use(logger('dev'));
app.use(compression());
app.use(express.static(path.resolve(__dirname, 'client')));

app.set('port', process.env.PORT || 4000);
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.set('views', __dirname + '/client/views');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
// required for passport
app.use(session({ secret: 'letthegamebegins' })); // session secret
app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions
app.use(cookieParser());

// required for cookie session
app.use(session({ 
key:'user_sid',
secret: 'letthegamebegins',
resave:false,
saveUninitialized:false,
cookie:{
    expires:600000
} 

}));

app.use((req, res, next) => {
    if (req.cookies.user_sid && !req.session.user) {
        res.clearCookie('user_sid');        
    }
    next();
});

var sessionChecker = (req, res, next) => {
    if (req.session.user && req.cookies.user_sid) {
        console.log(req.session.user);
        res.redirect(req.session.user.Role);
    } else {
        next();
    }    
};

// =========================================================================
// authentication ======================  for user ===============
//==========================================================================

// route for user signup
// app.route('/signup')
//     .get(sessionChecker, (req, res) => {
//         res.render('login/login.ejs',{
//             user:req.session.user,
//             message: ''
//         });
//     })
//     .post((req, res) => {
//         User.create({
//             name: req.body.first_name,
//             lastname: req.body.last_name,
//             email: req.body.email,
//             password: req.body.password,
//             Role: 'member',
//             verify: 0
//         })
//         .then(user => {
//             checkEmail(req.session.user.email);
//             req.session.user = user.dataValues;
//             res.redirect('/member');
//         })
//         .catch(error => {
//             res.render('login/login.ejs',{
//                 user: null,
//                 message: 'Email id is already in use'
//             });
//         });
//     });

// app.route('/signup1')
//     .post((req, res) => {
//         User.create({
//             name: req.body.company_name,
//             //lastname: req.body.last_name,
//             email: req.body.email,
//             Role : 'company',
//             password: req.body.password,
//             verify:0
//         })
//         .then(user => {
//             req.session.user = user.dataValues;
//             checkEmail(req.session.user.email);
//             res.redirect('/company');
//         })
//         .catch(error => {
//             res.redirect('/signup');
//         });
//     });

// // route for user Login
// app.route('/login')
//     .get(sessionChecker, (req, res) => {
//         res.render('login/login.ejs',{
//             user:req.session.user,
//             message:''
//         });
//     })
//     .post((req, res) => {
//         var email = req.body.email,
//             password = req.body.password;

//         User.findOne({ where: { email: email } }).then(function (user) {
//             if (!user) {
//                 res.render('login/login.ejs',{
//                     user: null,
//                     message: 'User does not exit'
//                 });
//             } else if (!user.validPassword(password)) {
//                 res.render('login/login.ejs',{
//                     user: null,
//                     message: 'Oops! wrong password'
//                 });
//             }else if(user.verify ===0){
//                 checkEmail(user.email);
//                 res.render('login/login.ejs',{
//                     user:null,
//                     message: 'Please verify your account email sent'
//                 });

//             }
//              else {
//                 req.session.user = user.dataValues;
//                 res.redirect(req.session.user.Role);
//             }
//         });
//     });


// route for user's dashboard
// app.get('/dashboard', (req, res) => {
//     if (req.session.user && req.cookies.user_sid) {
//         res.sendFile(__dirname + '/public/dashboard.html');
//     } else {
//         res.redirect('/login');
//     }
// });




// =========================================================================
// Cors setting ======================  for referencing ===============
//==========================================================================
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

var usernum =0;
// app.use(function (req, res, next) {
//   // check if client sent cookie
//   var cookie = req.cookies.cookieName;
//   if (cookie === undefined)
//   {
//     // no: set a new cookie
//     var randomNumber=Math.random().toString();
//     randomNumber=randomNumber.substring(2,randomNumber.length);
//     usernum++;
//     res.cookie('cookieName',usernum, { maxAge: 900000, httpOnly: false });
//     console.log('cookie created successfully');
//   }
//   else
//   {
//     // yes, cookie was already present
//     console.log('cookie exists', cookie);
//   }
//   next(); // <-- important!
// });
// normal routes ===============================================================
app.use('/', mainRoutes);



    function parseIt(rawData){
    rawData = JSON.stringify(rawData);
    rawData = JSON.parse(rawData);
    return rawData;
}

// PROFILE SECTION =========================
app.get('/profile', isLoggedIn, function(req, res) {
    res.render('profile.ejs', {
        user : req.user
    });
});


// route middleware to ensure user is logged in
function isLoggedIn(req, res, next) {
    if (req.isAuthenticated())
        return next();
    res.redirect('/');
}
app.listen(app.get('port'), function () {
    console.log('Application running in port '+ app.get('port'));
});