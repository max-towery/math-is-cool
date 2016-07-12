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
    public class RegistrationTypeController : ApiController
    {
        // GET: api/RegistrationType
        public IEnumerable<registration_type> Get()
        {
            List<registration_type> types = new List<registration_type>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                types = items.registration_types.ToList();
            }
            return types;
        }

        // GET: api/RegistrationType/5
        public IHttpActionResult Get(int id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (registration_type type in items.registration_types)
                {
                    if (id == type.id)
                    {
                        return Ok(type);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/RegistrationType
        [HttpPost]
        public IHttpActionResult Post(registration_type value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.registration_types.InsertOnSubmit(value);
                try
                {
                    items.SubmitChanges();
                    return Ok(value);
                }
                catch (Exception e)
                {
                    return NotFound();
                }
            }
        }

        // PUT: api/RegistrationType/5
        [HttpPut]
        public void Put([FromUri]int id, registration_type value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                registration_type existingRegType = (from r in items.registration_types where r.id == value.id select r).SingleOrDefault();
                existingRegType.value = value.value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/RegistrationType/5
        public void Delete(int id)
        {
        }
    }
}
