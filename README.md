# gcf-oga-transcoder
Proof-of-concept app: Google Cloud Function FLAC to OGA transcoder.

This is a spike to confirm that we can create a Google Cloud Function to call ffmpeg to transcode FLAC files to OGG/OGA files, and return the files in reasonable time.

- Caching the files is currently not considered.
- No logging/monitoring.
- This is a spike, so tests aren't extensive.
- OGGs/OGAs are inherently streamable, therefore there's no need to implement range requests for now.
The test server (fake backend) server always looks for a file called test01.flac in the /assets folder, so that needs to be placed there in order to do testing. After doing this, `make test` runs tests.
