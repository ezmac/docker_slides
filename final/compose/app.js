const express = require('express')
const app = express()
const port = 4300
var MongoClient = require('mongodb').MongoClient

// I'm not a node dev; excuse me if there are logical errors in how this operates

// # build mongo connection string from process.env variables
const connectionString = `mongodb://${process.env.MONGO_USER}:${process.env.MONGO_PASSWORD}@${process.env.MONGO_HOST}:${process.env.MONGO_PORT}/${process.env.MONGO_DB_NAM}?authMechanism=DEFAULT&authSource=admin&ssl=false` ;

// create client connection pool
const client = new MongoClient(connectionString, {poolSize: 2, retryMiliSeconds: 3000, numberOfRetries: 10});

function safeConnect(retries, client){
  client.connect(function (err) {
    console.log("trying connection");
    if (err) {
      console.log("trying connection failed");
      if (retries){
        return setTimeout(safeConnect.bind(null,retries--, client), 1*1000);
      }
      else {
        throw err; //oh crap
      }
    }

    console.log("connection established");
    var db = client.db(process.env.MONGO_DB_NAME)
    db.collection('people').drop(function(err, r){
      if (err) console.log('db not found, continuing')
      else console.log('db dropped, continuing')
    })

    db.collection('people').insertOne({first_name:"world"}, function(err, r) {
      if (err) throw err;
    });
    db.collection('people').insertOne({first_name:"Ithaca Web People"}, function(err, r) {
      if (err) throw err;
    });

  })
}
safeConnect(5, client);

app.get('/', (req, res) => res.send('Hello World!'))

app.get('/hello', (req, res) => {
  var db = client.db(process.env.MONGO_DB_NAME)
  db.collection('people').find().toArray(function (err, result) {
    body="";
    if (err) throw err
    result.forEach((person) => {
      body+=`Hello ${person.first_name}!<br/>`;

      console.log(person)
    })
    res.send(body);
  })
})

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
