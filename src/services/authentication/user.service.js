/* Service layer for users database interaction */
const bcrypt = require('bcrypt');
const { database } =require('../../helpers/utils/db/database');

function findUserByEmail(email) {
    return database.user.findUnique({
        where: { email }
    });
}

function createUserByEmailAndPassword(user) {
    user.password = bcrypt.hashSync(user.password, 12);
    return database.user.create({
        data: user
    });
}

function findUserById(id) {
    return database.user.findUnique({
        where: { id }
    });
}

module.exports = {
    findUserByEmail,
    createUserByEmailAndPassword,
    findUserById
};