const db = require("../models");
const Photo = db.photo;
const Op = db.Sequelize.Op;
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/../configs/global.config.json')[env];
const sequelize = db.sequelize;

const upload = (req, res) => {
    // Validate request
    if (!req.body.memberId) {
        res.status(400).send({
            message: "memberId can not be empty!"
        });
        return;
    }

    if (!req.file.filename) {
        res.status(400).send({
            message: "filename can not be empty!"
        });
        return;
    }

    // // Create a Photo
    const photo = {
        name: req.file.originalname,
        path: config.image_url + '/' + req.file.filename,
        memberId: req.body.memberId
    };

    console.log(photo)

    // // Save Photo in the database
    Photo.create(photo)
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while creating the Photo."
            });
        });
};
const findAll = function (req, res) {

    const name = req.query?.name ? req.query.name : '';
    var condition = name ? { name: { [Op.iLike]: `%${name}%` } } : null;
    Photo.findAll({
        attributes: [
            ['photo_id', 'id'],
            ['member_id', 'memberId'],
            [sequelize.literal(`(
                    SELECT member_name
                    FROM members
                    WHERE
                        members.member_id = photo.member_id
                )`),
                'memberName'],
            ['photo_name', 'name'],
            ['photo_path', 'path'],
            [sequelize.fn('to_char', sequelize.col('photo.updatedAt'), 'YYYY-MM-DD HH24:MI:SS'), 'updatedAt']
        ],
        where: condition
    }).then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send({
            message:
                err.message || "Some error occurred while retrieving Photos."
        });
    });
};
const findById = (req, res) => {
    const id = req.params.id;

    Photo.findByPk(id)
        .then(data => {
            res.send(data);
        }).catch(err => {
            res.status(500).send({
                message: "Error retrieving Photo with id=" + id
            });
        });
};

module.exports = {
    upload,
    findById,
    findAll
};