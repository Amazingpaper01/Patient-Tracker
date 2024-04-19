const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const User = require('../models/User');
const Patient = require('../models/Patient');

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
        res.json({ message: `Welcome ${user.firstName}` });
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

// Generate a unique 6-digit patientID for each patient
function generatePatientID() {
    return Math.floor(100000 + Math.random() * 900000);
};

// Allows staff to create a new patient
const createpatient = async (req, res) => {
    const { firstName, lastName, gender, bloodtype, doctorName, roomNum, condition, medications } = req.body;
    try {
        // Checks to make sure patientID does not already exist
        let patientID =  generatePatientID();
        let existingPatient = await Patient.findOne({ patientID });

        // If it does exist, generate a new one
        while (existingPatient) {
          patientID =  generatePatientID();
          existingPatient = await Patient.findOne({ patientID });
        }

        // Create a new patient with the unique patientID
        const newPatient = new Patient({ firstName, lastName, gender, bloodtype, doctorName, roomNum, condition,
            medications, patientID, admissionDate: new Date(), dischargeDate: null });

        // Save the new patient to the database
        newPatient.save();
        res.status(200).json(newPatient);
    } catch {
        res.status(400).json( error.message );
    }
};

// Retrieve patient information from database
const addpatient = async (req, res) => {
    const { patientID } = req.body;

    try {
        const patient = await Patient.findOne({ patientID });

        if (!patient) {
            return res.status(404).json({ message: `Patient ${patientID} not found.` });
        }
        return res.json({ message: `Patient ${patient.firstName} ${patient.lastName} added.` });
    } catch {
        return res.status(500).send("Internal server error.");
    }
};

// Modify patient information in the database
const modifypatient = async (req, res) => {
    try {
        const { patientID } = req.params;
        const { attribute, value } = req.body;

        const patient = await Patient.findById(patientID);

        patient[attribute] = value;

        await patient.save();
        return res.status(200).json(updatedPatient);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

module.exports = { register, login, logout, createpatient, addpatient, modifypatient };