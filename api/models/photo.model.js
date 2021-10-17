module.exports = (sequelize, Sequelize) => {
    const Photo = sequelize.define("photo", {
        id: {
            type: Sequelize.INTEGER,
            field: 'photo_id',
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: Sequelize.STRING,
            field: 'photo_name'
        },
        path: {
            type: Sequelize.STRING,
            field: 'photo_path'
        },
        memberId: {
            type: Sequelize.INTEGER,
            field: 'member_id'
        }
    });

    return Photo;
};
