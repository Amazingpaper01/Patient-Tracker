const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const patientSchema = new mongoose.Schema(
    {
        firstName: {
            type: String,
            required: true,
            unique: false
        },
        lastName: {
            type: String,
            required: true,
            unique: false
        },
        gender: {
            type: String,
            required: true,
            enum: ['Male', 'Female', 'Nonbinary', 'Decline to answer'],
            unique: false
        },
        bloodtype: {
            type: String,
            required: false,
            default: 'Unknown'
        },
        doctorName: {
            type: String,
            required: true,
            unique: false
        },
        roomNum: {
            type: String,
            required: true,
            unique: false
        },
        condition: {
            type: String,
            required: false,
            unique: false,
            default: 'Pending'
        },
        medications: {
            type: String,
            required: false,
            unique: false
        },
        patientID: {
            type: Number,
            unique: true
        },
        admissionDate: {
            type: Date,
            default: Date.now
        },
        dischargeDate: {
            type: Date,
            default: null
        }
    },
    { timestamps: false}
);

const Patient  = mongoose.model('Patient', patientSchema);

module.exports = Patient;