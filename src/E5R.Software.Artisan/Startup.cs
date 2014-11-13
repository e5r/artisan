using Owin;
using System.Web.Http;

namespace E5R.Software.Artisan
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseWebApi(MakeWebApiConfig());
        }

        private HttpConfiguration MakeWebApiConfig()
        {
            var config = new HttpConfiguration();
            config.MapHttpAttributeRoutes();
            return config;
        }
    }
}
