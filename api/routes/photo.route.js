const { json } = require("body-parser");

module.exports = app => {
    const photos = require("../controllers/photo.controller.js");

    const uploader = require("../middlewares/uploader.middleware");

    var router = require("express").Router();

    // Create a new Photo
    router.post("/", uploader, photos.upload);

    // Retrieve a single Photo with id
    router.get("/:id", photos.findById);

    // Retrieve all photos
    router.get("/", photos.findAll);

    app.use("/api/photos", router);
};