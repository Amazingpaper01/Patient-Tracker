const express = require('express');
const app = express();
const connectDB = require('./db');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const User = require('./models/User');

// Connect to MongoDB
connectDB();

// Middleware
app.use(express.json());

// Define routes
app.use('/auth', authRoutes);
app.use('/user', userRoutes);

// Starts the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log('Server started on port ${PORT}');
});

// app.post("/login", (req, res) => {
//     // Access and log the email and password from the JSON body
//     console.log("Email:", req.body.email);
//     console.log("Password:", req.body.password);
  
//     // Send a response to the client
//     res.send("Login Success!");
//   });

// User login
app.post("/login", async function (req, res){
    try {
        // check if user exists
        const user = await user.findOne({email: req.body.email})
        const result = req.body.password === user.password;
        if (user && result) {
            // check if password matches
                res.render("secret");
        } else {
            res.status(400).json({ error: "Email or password do not match"});
        }
    } catch (error) {
        res.status(400).json({error});
    }
});

// User signup
app.post("/register", async (req, res) => {;
    const user = await User.create({
        username: req.body.username,
        email: req.body.email,
        password: req.body.password,
        role: req.body.role
    });

    return res.status(200).json(user);
});

/*
app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}));
app.use(require("express-session")({
    secret: "This is the secret",
    resave: false,
    saveUnitialized: false
}));

app.use(passport.initialize());
app.use(passport.session());

passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());

// ---------- Requests

// Home
app.get("/", function (req, res) {
    res.render("home");
});

// Secret
app.get("/secret", isLoggedIn, function (req, res) {
    res.render("secret");
});

// Register
app.get("/register", function (req, res) {
    res.render("register");
});

// User signup
app.post("/register", async (req, res) => {
    const user = await User.create({
        username: req.body.username,
        password: req.body.passport
    });

    return res.status(200).json(user);
});

// Login form
app.get("/login", function (req, res) {
    res.render("login");
});

// User login
app.post("/login", async function (req, res){
    try {
        // check if user exists
        const user = await User.findOne({username: req.body.username});
        const result = req.body.password === user.password;
        if (user && result) {
            // check if password matches
                res.render("secret");
        } else {
            res.status(400).json({ error: "Username or password do not match"});
        }
    } catch (error) {
        res.status(400).json({error});
    }
});

// User logout
app.get("/logout", function (req, res) {
    req.logout(function(err) {
        if (err) { return next(err); }
        res.redirect('/');
    });
});

function isLoggedIn(req, res, next) {
    if (req.isAuthenticated()) return next();
    res.redirect("/login");
}
let port = process.env.PORT || 3000;
app.listen(port, function () {
    console.log("Connected to server");
});
*/