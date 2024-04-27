const express = require('express');
const app = express();
const connectDB = require('./db');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const cors = require('cors');
const server = require('http').createServer();
const io = require('socket.io')(server);

// Listen for incoming connections
io.on('connection', (socket) => {
  console.log('A user connected');

  // Listen for incoming messages
  socket.on('chat message', (msg) => {
    console.log('message: ' + msg);

    // Broadcast the message to all connected clients (including sender)
    io.emit('chat message', msg);
  });

  // Handle disconnection
  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

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