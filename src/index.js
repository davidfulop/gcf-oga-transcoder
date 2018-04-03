const request = require('request');

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.trackGET = (req, res) => {
    request('http://test-server:80/media/0', function (error, response, body) {
    }).pipe(res);
};
