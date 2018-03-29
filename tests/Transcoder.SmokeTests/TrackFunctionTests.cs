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
            
            Assert.AreEqual(HttpStatusCode.OK, response.StatusCode, $"Unexpected {response.StatusCode} status.");

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
                Assert.IsTrue(stringResponse.Length > ONE_MEG, $"Response from backend: {stringResponse}");
            }
            
        }
    }
}
