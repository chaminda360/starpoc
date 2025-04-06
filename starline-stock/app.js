const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3001;

// Middleware
app.use(express.json());

// MySQL connection setup
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'starline_stock_db'
});

db.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }
  console.log('Connected to the starline_stock_db database.');
});

// Routes
app.get('/', (req, res) => {
  res.send('Welcome to the Starlink Express App!');
});

// Endpoint to get all products
app.get('/products', (req, res) => {
  const query = 'SELECT * FROM products';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching products:', err);
      res.status(500).send('Error fetching products');
      return;
    }
    res.json(results);
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Starline-stock app listening at http://localhost:${port}`);
});
