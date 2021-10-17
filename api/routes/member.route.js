module.exports = app => {
    const members = require("../controllers/member.controller.js");

    var router = require("express").Router();

    // Create a new Member
    router.post("/", members.create);

    // Retrieve a single Member with id
    router.get("/:id", members.findById);

    // Update a Member with id
    router.put("/:id", members.update);

    // Retrive all photos by id
    router.get("/:id/photos", members.findPhotoByMemberId);

    // Signin a member
    router.post("/signin", members.signin);

    app.use("/api/members", router);
};