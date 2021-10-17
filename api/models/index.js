const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/../configs/db.config.json')[env];

let sequelize;
if (config.database_url) {
    sequelize = new Sequelize(config.database_url, config);
} else {
    sequelize = new Sequelize(config.database, config.username, config.password, config);
}

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.member = require("./member.model.js")(sequelize, Sequelize);
db.photo = require("./photo.model.js")(sequelize, Sequelize);

db.member.hasMany(db.photo, {
    as: "photos"
});

db.photo.belongsTo(db.member, {
    forignKey: 'member_id',
    as: 'member'
});

module.exports = db;