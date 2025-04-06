const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3000;

// Middleware
app.use(express.json());

// MySQL connection setup
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'starline_service_db'
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Connected to the starline_service_db database.');
});

// Routes
app.get('/', (req, res) => {
  res.send('Welcome to the Starlink Express App!');
});

// Endpoint to get all users
app.get('/users', (req, res) => {
  const query = 'SELECT * FROM users';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching users:', err);
      res.status(500).send('Error fetching users');
      return;
    }
    res.json(results);
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Starlink app listening at http://localhost:${port}`);
});
