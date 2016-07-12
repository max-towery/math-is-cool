using MathIsCool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MathIsCool.Controller
{
    public class RolesController : ApiController
    {
        // GET: api/Roles
        public IEnumerable<roles> Get()
        {
            List<roles> roles = new List<roles>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                roles = items.roles1.ToList();
            }
            return roles;
    }

        // GET: api/Roles/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/Roles
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Roles/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Roles/5
        public void Delete(int id)
        {
        }
    }
}
