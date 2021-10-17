module.exports = (sequelize, Sequelize) => {
    const Member = sequelize.define("member", {
        id: {
            type: Sequelize.INTEGER,
            field: 'member_id',
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: Sequelize.STRING,
            field: 'member_name'
        },
        email: {
            type: Sequelize.STRING,
            field: 'member_email'
        },
        password: {
            type: Sequelize.STRING,
            field: 'member_password'
        }
    });

    return Member;
};