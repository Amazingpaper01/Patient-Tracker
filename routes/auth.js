const express = require('express');
const { register, login, logout, createpatient, addpatient, modifypatient } = require('../controllers/auth');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.post('/logout', logout);
router.post('/createpatient', createpatient);
router.post('/addpatient', addpatient);
router.post('/modifypatient', modifypatient);

module.exports = router;