/* Basic properties for express, body-parser, and controllers route */
const express = require('express')
const bodyParser = require('body-parser');

/* Necessary variables */
const PORT = process.env.PORT || 3001;
const main = express();

main.use(bodyParser.json());
main.use(bodyParser.urlencoded ({
    extended: false
}));

main.listen(PORT, () => {
    console.log('Server is running! port: ' + PORT);
});