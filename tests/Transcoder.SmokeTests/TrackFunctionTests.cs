using System.Diagnostics;
using System.IO;
using System.Net;
using NUnit.Framework;

namespace Transcoder.SmokeTests
{
    public class TrackFunctionTests
    {
        const string TRACK_FUNCTION_URL = "http://gcf-local:8010/functionstest/us-central1/trackGET";
        const int ONE_MEG = 1024 * 1024;

        [Test]
        public void Returns_200OK_for_valid_request()
        {
            var request = WebRequest.Create(TRACK_FUNCTION_URL);
            var response = request.GetResponse() as HttpWebResponse;
            
            Assert.AreEqual(HttpStatusCode.OK, response.StatusCode, 
                $"Unexpected {response.StatusCode} status.");
        }

        [Test]
        public void Returns_media_for_valid_request()
        {
            var request = WebRequest.Create(TRACK_FUNCTION_URL);
            var response = request.GetResponse() as HttpWebResponse;
            var responseStream = response.GetResponseStream();
            var stringResponse = string.Empty;
            using (var sr = new StreamReader(responseStream))
            {
                stringResponse = sr.ReadToEnd();
                Assert.IsTrue(stringResponse.Length > ONE_MEG, 
                    $"Response from backend: {stringResponse}");
            }            
        }

        [Test]
        public void Returns_audio_ogg_as_content_type()
        {
            var request = WebRequest.Create(TRACK_FUNCTION_URL);
            var response = request.GetResponse() as HttpWebResponse;
            Assert.AreEqual("audio/ogg", response.Headers["Content-Type"], 
                $"Unexpected Content-Type header: {response.Headers["Content-Type"]}");
        }

        [Test]
        public void Returned_file_contains_oga_contents()
        {
            var request = WebRequest.Create(TRACK_FUNCTION_URL);
            var response = request.GetResponse() as HttpWebResponse;
            var responseStream = response.GetResponseStream();
            
            var fs = File.Create("test.oga");
            responseStream.CopyTo(fs);
            fs.Close();

            var command = $"ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=nokey=1:noprint_wrappers=1 test.oga";            
            var process = new Process() { StartInfo = new ProcessStartInfo {
                    FileName = "/bin/bash",
                    Arguments = $"-c \"{command}\"",
                    CreateNoWindow = true,
                    RedirectStandardOutput = true,
                    UseShellExecute = false                    
                }
            };
            process.Start();
            string result = process.StandardOutput.ReadLine();
            process.WaitForExit();
            
            Assert.That(result == "vorbis", $"Unexpected audio type: [{result}].");
        }
    }
}
