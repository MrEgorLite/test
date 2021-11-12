
const express = require("express");
const mysql = require("mysql2/promise");

let db = null;
const app = express();

app.use(express.json());

app.post('/create-car', async(req, res, next)=>{
  const id = req.body.id;
  const make = req.body.make;
  const model = req.body.model;
  const licencePlate = req.body.licencePlate;
  await db.query("INSERT INTO testcar (id,make,model,licencePlate) VALUES (?,?,?,?);", [id,make,model,licencePlate]);
  //console.log(id,make,model,licencePlate);

  res.json({status:"OK"});
  next();
});
app.get('/testcar', async (req, res, next) => {

  const [rows] = await db.query("SELECT * FROM testcar;");

  res.json(rows);
  next();
});
app.post('/Edit-car', async(req, res, next)=>{
  const id = req.body.id;
  const make = req.body.make;
  const model = req.body.model;
  const licencePlate = req.body.licencePlate;
  //await db.query("INSERT INTO testcar (id,make,model,licencePlate) VALUES (?,?,?,?);", [id,make,model,licencePlate]);
  await db.query("UPDATE testcar SET make = ?, model = ?, licencePlate = ? WHERE id = ?;",[make,model,licencePlate,id]);
  
  res.json({status:"OK"});
  next();
});
app.post('/REdit-car', async(req, res, next)=>{
  const id = req.body.id;
  const newid = id-1;
  const make = req.body.make;
  const model = req.body.model;
  const licencePlate = req.body.licencePlate;
  //await db.query("INSERT INTO testcar (id,make,model,licencePlate) VALUES (?,?,?,?);", [id,make,model,licencePlate]);
  //await db.query("UPDATE testcar SET make = ?, model = ?, licencePlate = ?  WHERE id = ?;",[make,model,licencePlate,id]);
  await db.query("UPDATE testcar SET id = replace(id,?,?);",[id,newid]);
  
  res.json({status:"OK"});
  next();
});
app.post('/Remove-car', async(req, res, next)=>{
  const id = req.body.id;
  const make = req.body.make;
  const model = req.body.model;
  const licencePlate = req.body.licencePlate;
  //await db.query("INSERT INTO testcar (id,make,model,licencePlate) VALUES (?,?,?,?);", [id,make,model,licencePlate]);
  await db.query("DELETE FROM testcar  WHERE id = ?;",[id]);
  
  res.json({status:"OK"});
  next();
});

async function main(){
  db = await mysql.createConnection({
    host:"localhost",
    user: "root",
    password: "test1234",
    database: "flutter_nodejs",
    timezone: "+02:00",
    charset: "utf8mb4_general_ci",
  });

  app.listen(8000);
}

main();