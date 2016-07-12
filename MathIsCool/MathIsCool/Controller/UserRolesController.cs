using MathIsCool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MathIsCool.Controller
{
    public class UserRolesController : ApiController
    {
        // GET: api/UserRoles
        public IEnumerable<UserRole> Get()
        {
            List<UserRole> roles = new List<UserRole>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                roles = items.UserRoles.ToList();
            }
            return roles;
        }

        // GET: api/UserRoles/5
        public IHttpActionResult Get([FromUri]string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (UserRole role in items.UserRoles)
                {
                    if (id.Equals(role.UserId.ToString()))
                    {
                        return Ok(role);
                    }
                }
            }

            return Ok(id);
        }

        // POST: api/UserRoles
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/UserRoles/5
        [HttpPut]
        public void Put([FromUri]string id, UserRole value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                UserRole existingUserRole = (from u in items.UserRoles where u.UserId == value.UserId select u).SingleOrDefault();
                existingUserRole.RoleId = value.RoleId;


                items.SubmitChanges();
            }
        }

        // DELETE: api/UserRoles/5
        public void Delete(int id)
        {
        }
    }
}
