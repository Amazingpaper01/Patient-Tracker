const express = require('express');
const app = express();
const connectDB = require('./db');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const cors = require('cors');


// Connect to MongoDB
connectDB();
app.use(cors());

// Middleware
app.use(express.json());

// Define routes
app.use('/auth', authRoutes);
app.use('/user', userRoutes);

// Starts the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});