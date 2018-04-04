const request = require('request');
var ffmpeg = require('ffmpeg-stream').ffmpeg;
var fs = require('fs');

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.trackGET = (req, res) => {
    res.setHeader("content-type", "audio/ogg");
    var converter = ffmpeg();

    var input = converter.input({f: 'flac'});
    request('http://test-server:80/media/0', function (error, response, body) {
    }).pipe(input);
    
    converter.output({f: 'oga', acodec: 'libvorbis'})
    .pipe(res);
     
    converter.run();
};
