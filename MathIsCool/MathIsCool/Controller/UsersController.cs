using MathIsCool.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MathIsCool.Controller
{
    public class UsersController : ApiController
    {
        // GET: api/Users
        public IEnumerable<users> Get()
        {
            List<users> users = new List<users>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                users = items.users1.ToList();
            }
            return users;
        }

        // GET: api/Users/5
        public IHttpActionResult Get([FromUri]string username)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (users user in items.users1)
                {
                    if (username.Equals(user.UserName))
                    {
                        return Ok(user);
                    }
                }
            }
            return Ok(username);
        }

        // POST: api/Users
        [HttpPost]
        public void Post(User1 value)
        {

        }

        // PUT: api/Users/5
        [HttpPut]
        public void Put([FromUri]string id, User1 value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                User1 existingUser = (from u in items.User1s where u.UserID == value.UserID select u).SingleOrDefault();
                existingUser.Email = value.Email;
                existingUser.FirstName = value.FirstName;
                existingUser.LastName = value.LastName;
                existingUser.PhoneNumber = value.PhoneNumber;
                existingUser.UserName = value.UserName;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Users/5
        [HttpDelete]
        public void Delete([FromUri]string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                User1 userToDelete = (from u in items.User1s where u.UserID.ToString() == id select u).First();
                items.User1s.DeleteOnSubmit(userToDelete);

                items.SubmitChanges();
            }
        }
    }
}
