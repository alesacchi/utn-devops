module.exports = {
  HOST: "mysql",
  USER: "root",
  PASSWORD: "root",
  DB: "devops_app",
  dialect: "mysql",
  pool: {
    max: 5,
    min: 0,
    acquire: 30000,
    idle: 10000
  }
};
