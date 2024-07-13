const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('<h1>Hello, WELCOME TO THE GEN AI World!</h1><p>Welcome to my simple web app!</p>');
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
