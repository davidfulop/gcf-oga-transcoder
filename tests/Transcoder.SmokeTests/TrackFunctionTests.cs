using System.Net;
using NUnit.Framework;

namespace Transcoder.SmokeTests
{
    public class TrackFunctionTests
    {
        const string TRACK_FUNCTION_URL = "http://gcf-local:8010/functionstest/us-central1/trackGET";

        [Test]
        public void Returns_200OK_for_valid_request()
        {
            var request = WebRequest.Create(TRACK_FUNCTION_URL);
            var response = request.GetResponse() as HttpWebResponse;
            
            Assert.AreEqual(HttpStatusCode.OK, response.StatusCode, $"Unexpected {response.StatusCode} status.");

        }
    }
}
