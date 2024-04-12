const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const User = require('../models/User');

// Register new user
const register = async (req, res, next) => {
    const { firstName, lastName, email, password } = req.body;

    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new User({ firstName, lastName, email, password: hashedPassword });
        await user.save();
        res.json({ message: 'Registration Successful' });
    } catch (error) {
        next(error);
    }
};

// Login with existing account
const login = async (req, res, next) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        const passwordMatch = await user.comparePassword(password);
        if (!user || !passwordMatch) {
            return res.status(401).json({ message: 'Email or password is incorrect' });
        }

        const token = jwt.sign({ userId: user._id }, process.env.SECRET_KEY, {
            expiresIn: '1 hour'
        });
        res.json({ token });
        //console.log(req.body);
        //res.status(200).json(user);
        //res.send({ test: `Hello ${user.firstName}`})
    } catch (error) {
        next(error);
    }
};

// Log out of account
const logout = async (req, res) => {
    req.session.destroy((err) => {
        if (err) {
          console.log(err);
          return res.status(500).send('Error logging out');
        }
        res.status(200).send('Logged out successfully');
      });
};

module.exports = { register, login, logout };