const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');
const app = express();
app.use(cors());
app.use(express.json());

let products = [
  { id: uuidv4(), name: 'Laptop', price: 1000 },
  { id: uuidv4(), name: 'Phone', price: 500 }
];

app.get('/products', (req, res) => res.json(products));
app.post('/products', (req, res) => {
  const { name, price } = req.body;
  const p = { id: uuidv4(), name, price };
  products.push(p);
  res.status(201).json(p);
});

app.listen(5002, () => console.log('Product Service running on 5002'));
