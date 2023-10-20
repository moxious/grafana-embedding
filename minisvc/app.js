const express = require('express')
const app = express()
const port = 3000

const snooze = ms => new Promise(resolve => setTimeout(resolve, ms));

app.get('/', async (req, res) => {

  if(Math.random() < 0.08) {
    return res.status(500).send('failure');
  }

  if(Math.random() < 0.5) {
    await snooze(Math.floor(Math.random() * (1500 - 400 + 1) + 400));
  }

  return res.send('Hello World!')
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
