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
    public class RegistrationsController : ApiController
    {
        // GET: api/Registrations
        public IEnumerable<registration> Get()
        {
            List<registration> registrations = new List<registration>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                registrations = items.registrations.ToList();
            }
            return registrations;
        }

        // GET: api/Registrations/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (registration reg in items.registrations)
                {
                    if (id.Equals(reg.reg_id.ToString()))
                    {
                        return Ok(reg);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Registrations
        [HttpPost]
        public IHttpActionResult Post(registration value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.registrations.InsertOnSubmit(value);
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

        // PUT: api/Registrations/5
        [HttpPut]
        public void Put([FromUri]string id, registration value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                registration existingRegistration = (from r in items.registrations where r.reg_id == value.reg_id select r).SingleOrDefault();
                existingRegistration.coach_name = value.coach_name;
                existingRegistration.comp_level = value.comp_level;
                existingRegistration.is_paid = value.is_paid;
                existingRegistration.num_teams = value.num_teams;
                existingRegistration.registration_type = value.registration_type;
                existingRegistration.school_id = value.school_id;
                existingRegistration.user_id = value.user_id;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Registrations/5
        public void Delete(int id)
        {
        }
    }
}
