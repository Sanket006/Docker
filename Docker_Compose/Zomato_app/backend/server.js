const express = require('express');
const mongoose = require('mongoose');
const app = express();

mongoose.connect('mongodb://db:27017/zomato', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('✅ Connected to MongoDB'))
  .catch(err => console.log('❌ MongoDB connection failed:', err));

app.get('/', (req, res) => {
  res.send('Zomato Backend Running 🚀');
});

app.get('/restaurants', (req, res) => {
  res.json([
    { name: 'Burger King', location: 'Mumbai', rating: 4.3 },
    { name: 'Pizza Hut', location: 'Delhi', rating: 4.1 }
  ]);
});

app.listen(5000, () => console.log('Backend server running on port 5000'));
