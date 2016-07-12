using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MathIsCool.Startup))]
namespace MathIsCool
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
