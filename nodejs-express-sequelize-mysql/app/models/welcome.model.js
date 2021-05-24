module.exports = (sequelize, Sequelize) => {
  const Welcome = sequelize.define("welcome", {
    id: {
      type: Sequelize.STRING,
      primaryKey: true
    },
    description: {
      type: Sequelize.STRING
    }
  });

  return Welcome;
};
