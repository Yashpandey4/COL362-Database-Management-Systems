const { Pool, Client } = require('pg');

const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'fifa',
  password: '1234',
  port: 5432,
});

// const client = new Client({
//   user: 'postgres',
//   host: 'localhost',
//   database: 'fifa',
//   password: '1234',
//   port: 5432,
// });


client.connect(function(err){
    if(!err) {
        console.log("Database is connected");
    } else {
        console.log(err);
        console.log("Error while connecting with database");
 		// console.log(err);
    }
});

// client.query('select * from country;', (err, res) => {
//   console.log(res.rows)
//   client.end()
// })

module.exports = client;