module.exports = app => {
  const welcoms = require("../controllers/welcome.controller.js");

  var router = require("express").Router();

  // Retrieve all Tutorials
  router.get("/", welcoms.findAllPublished);

  router.get("/hola", welcoms.hola);

  app.use('/api/welcome', router);
};
