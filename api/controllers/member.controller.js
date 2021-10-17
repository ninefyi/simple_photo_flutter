const db = require("../models");
const Member = db.member;
const Photo = db.photo;
const sequelize = db.sequelize;
const Op = db.Sequelize.Op;

const create = (req, res) => {
    // Validate request
    if (!req.body.name) {
        res.status(400).send({
            message: "Content can not be empty!"
        });
        return;
    }

    // Create a Member
    const member = {
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
    };

    // Save Member in the database
    Member.create(member)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while creating the Member."
            });
        });
};
const findById = (req, res) => {
    const id = req.params.id;

    Member.findByPk(id)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving Member with id=" + id
            });
        });
};
const findPhotoByMemberId = (req, res) => {
    const id = req.params.id;

    Photo.findAll({
        attributes: [
            ['photo_id', 'id'],
            ['photo_name', 'name'],
            ['photo_path', 'path'],
            [sequelize.fn('to_char', sequelize.col('photo.updatedAt'), 'YYYY-MM-DD HH24:MI:SS'), 'updatedAt']
        ],
        where: {
            'member_id': id
        }
    }).then(data => {
        res.send(data);
    }).catch(err => {
        res.status(500).send({
            message: "Error retrieving Photo with id=" + id + 'error:' + err
        });
    });

};
const update = (req, res) => {
    const id = req.params.id;

    Member.update(req.body, {
        where: { id: id }
    }).then(num => {
        if (num == 1) {
            res.send({
                message: "Member was updated successfully."
            });
        } else {
            res.send({
                message: `Cannot update Member with id=${id}. Maybe Member was not found or req.body is empty!`
            });
        }
    }).catch(err => {
        res.status(500).send({
            message: "Error updating Member with id=" + id
        });
    });


};
const signin = (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    // Validate request
    if (!req.body.email || !req.body.password) {
        res.status(400).send({
            message: "email / password can not be empty!"
        });
        return;
    }

    Member.findAll({
        attributes: [
            ['member_id', 'id'],
            ['member_name', 'name']
        ],
        where: {
            'member_email': email,
            'member_password': password
        },
        raw: true
    }).then(data => {
        if (data) {
            const m = {
                'id': data[0].id,
                'name': data[0].name
            }
            res.send(m);
        } else {
            res.send(data);
        }
    }).catch(err => {
        res.status(500).send({
            message: "Error:" + err
        });
    });

};

module.exports = {
    create,
    findById,
    findPhotoByMemberId,
    signin,
    update
}