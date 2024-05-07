const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const User = require('../models/User');
const Patient = require('../models/Patient');

// Register new user
const register = async (req, res, next) => {
    const { firstName, lastName, email, password } = req.body;

    try {
        const user = new User({ firstName, lastName, email, password });
        await user.save();
        res.json({ message: 'Registration Successful' });
        console.log("New user registered: " + email);
    } catch (error) {
        next(error);
    }
};

// Login with existing account
const login = async (req, res, next) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ message: 'Email not found'});
        }

        const passwordMatch = await user.comparePassword(password);
        if (!passwordMatch) {
            return res.status(404).json({ message: 'Password is incorrect' });           
        }

        // Generate JWT token
        const token = jwt.sign({ userId: user._id }, process.env.SECRET_KEY, {
            expiresIn: '1 hour'
        });

        res.json({ message: `Welcome ${user.firstName}` });
        console.log("User logged in: " + user.firstName + " " + user.lastName);
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
function genPatientID() {
    return Math.floor(100000 + Math.random() * 900000);
};

// Allows staff to create a new patient
const createpatient = async (req, res) => {
    const { firstName, lastName, gender, bloodtype, doctorName, roomNum, condition, medications } = req.body;
    try {
        // Checks to make sure patientID does not already exist
        let patientID =  genPatientID();
        let existingPatient = await Patient.findOne({ patientID });

        // If it does exist, generate a new one
        while (existingPatient) {
          patientID =  genPatientID();
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

        const sendPatient = { firstName: patient.firstName, lastName: patient.lastName, 
            patientID: patient.patientID, gender: patient.gender, doctorName: patient.doctorName,
            condition: patient.condition, medications: patient.medications, admissionDate: patient.admissionDate,
            bloodtype: patient.bloodtype, roomNum: patient.roomNum, dischargeDate: patient.dischargeDate };

        if (!patient) {
            return res.status(404).json({ message: `Patient ${patientID} not found.` });
        }
        return res.json(sendPatient);
    } catch {
        return res.status(500).send("Internal server error.");
    }
};

// Modify patient information in the database
const modifypatient = async (req, res) => {
    try {
        const { patientID, firstName, lastName, gender, bloodtype, medications, conditions,
            roomNum, doctorName } = req.body;

        const updates = {};
        if (firstName) {
          updates.firstName = firstName;
        }
        if (lastName) {
          updates.lastName = lastName;
        }
        if (gender) {
          updates.gender = gender;
        }
        if (bloodtype) {
          updates.bloodtype = bloodtype;
        }
        if (medications) {
          updates.medications = medications;
        }
        if (conditions) {
          updates.conditions = conditions;
        }
        if (roomNum) {
          updates.roomNum = roomNum;
        }
        if (doctorName) {
          updates.doctorName = doctorName;
        }
      
        const updatedPatient = await Patient.updateOne({ patientID }, { $set: updates });

        //await patient.save();
        return res.status(200).json(updatedPatient);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

const patientprofile = async (req, res) => {
    const { patientID } = req.body;

    try {
        const patient = await Patient.findOne({ patientID });

        const sendPatient = { firstName: patient.firstName, lastName: patient.lastName, 
            patientID: patient.patientID, gender: patient.gender, doctorName: patient.doctorName,
            condition: patient.condition, medications: patient.medications, admissionDate: patient.admissionDate,
            bloodtype: patient.bloodtype, roomNum: patient.roomNum, dischargeDate: patient.dischargeDate };

        if (!patient) {
            return res.status(404).json({ message: `Patient ${patientID} not found.` });
        }
        return res.json(sendPatient);
    } catch {
        return res.status(500).send("Internal server error.");
    }
};

// Modify patient information in the database
const dischargepatient = async (req, res) => {
    const { patientID } = req.body;

    try {
        const patient = await Patient.findOneAndUpdate({ patientID }, { dischargeDate: Date.now() }, { new: true});

        //await patient.save();
        return res.status(200).json({ message: `Patient discharged at ${ patient.dischargeDate }` });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
};

// POST request to test if connection works without database
const test = async (req, res) => {
    return res.json({ message: "hello world" });
};

module.exports = { register, login, logout, createpatient, addpatient, modifypatient, 
    patientprofile, dischargepatient, test };