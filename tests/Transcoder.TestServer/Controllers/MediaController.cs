using System.IO;
using Microsoft.AspNetCore.Mvc;

namespace Transcoder.TestServer.Controllers
{
    [Route("[controller]")]
    public class MediaController : Controller
    {
        [HttpGet("{id}")]
        public ActionResult Get(int id)
        {
            var fs = new FileStream("assets/test01.flac", FileMode.Open);
            return new FileStreamResult(fs, "audio/flac");
        }
    }
}
