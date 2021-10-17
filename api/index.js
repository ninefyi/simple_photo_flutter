const express = require("express");
const bodyParser = require("body-parser");
var cors = require('cors')

const app = express();

app.use('/uploads', express.static('uploads'));
app.use(cors())
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const db = require("./models");
db.sequelize.sync();

// simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome to Photos API." });
});

require("./routes/photo.route")(app);
require("./routes/member.route")(app);

// set port, listen for requests
const PORT = process.env.PORT || 9000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}.`);
});