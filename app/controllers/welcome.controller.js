const db = require("../models");
const Welcome = db.welcome;
const Op = db.Sequelize.Op;


exports.hola = (req, res) => {
res.send("hola");
};

exports.findAllPublished = (req, res) => {

  Welcome.findAll()
    .then(data => {
      console.log("data");
      console.log(data);
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving tutorials."
      });
    });
};

