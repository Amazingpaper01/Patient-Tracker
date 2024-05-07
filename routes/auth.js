const express = require('express');
const { register, login, logout, createpatient, addpatient, modifypatient, patientprofile, 
    dischargepatient, test } = require('../controllers/auth');
const { authenticate } = require('passport');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/logout', logout);
router.post('/createpatient', createpatient);
router.post('/addpatient', addpatient);
router.post('/modifypatient', modifypatient);
router.post('/patientprofile', patientprofile);
router.post('/dischargepatient', dischargepatient);
router.post('/test', test);

router.post('/profile', authenticate, (req, res) => {
    res.json({ message: `Welcome ${req.user.firstName}` });
});

module.exports = router;