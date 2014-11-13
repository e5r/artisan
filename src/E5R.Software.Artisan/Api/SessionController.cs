using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace E5R.Software.Artisan.Api
{
    [RoutePrefix(Config.ApiPrefix + "/session")]
    public class SessionController : TApiController
    {
        /// <summary>
        /// Cria uma nova sessão, lança exceção se já houver uma.
        /// NOTE: Verificar possibilidade de criar sessões distintas de usuário
        ///       ou applicativo.
        /// </summary>
        /// <returns></returns>
        [Route, HttpPost]
        public IHttpActionResult CreateUserSession(Data.View.UserSessionCreateForm userForm)
        {
            return Ok("Teste create...");
        }

        [Route(@"{appkey:regex(^[a-zA-Z0-9]+\=$)}"), HttpPost]
        public IHttpActionResult CreateAppSession(string appKey)
        {
            return Ok("Teste app create...");
        }

        /// <summary>
        /// Apaga a sessão existente. Lança exceção se não houver uma.
        /// </summary>
        /// <returns></returns>
        [Route, HttpDelete]
        public IHttpActionResult Delete()
        {
            return Ok("Teste deleted!");
        }
    }
}