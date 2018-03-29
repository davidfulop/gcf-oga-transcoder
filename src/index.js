const request = require('request');

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.trackGET = (req, res) => {
    var r = null;
    request('http://test-server:80/media/0', function (error, response, body) {
        res.status(200).send(response);
    });
};
