/* Utility class to generate tokens */
const jsonwebtoken = require('jsonwebtoken');

/* Generate access token and make it expired within 3 minutes */
function generateAccessToken(user) {
    return jsonwebtoken.sign({userId : user.id}, process.env.JWT_ACCESS_SECRET, {expiresIn: '3m'});
}

/* Generate refresh token and make it expired within 12 hours */
/* If the token expired user have to re-log in to the system */
function generateRefreshToken(user, jti) {
    return jsonwebtoken.sign (
        {userId: user.id, jti}, process.env.JWT_REFRESH_SECRET, {expiresIn: '12h'}
    );
}

/* Generate all tokens in one function */
function generateTokens(user, jti) {
    const accessToken = generateAccessToken(user);
    const refreshToken = generateRefreshToken(user, jti);

    return {
        accessToken,
        refreshToken,
    };
}

module.exports = {
    generateAccessToken,
    generateRefreshToken,
    generateTokens
};