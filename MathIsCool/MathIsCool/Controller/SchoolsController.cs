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
    public class SchoolsController : ApiController
    {
        // GET: api/
        public IEnumerable<schools> Get()
        {
            List<schools> schools = new List<schools>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                schools = items.schools1.ToList();
            }
            return schools;
        }

        // GET: api/Schools/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (school school in items.schools)
                {
                    if (id.Equals(school.school_id.ToString()))
                    {
                        return Ok(school);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Schools
        [HttpPost]
        public IHttpActionResult Post(school value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.schools.InsertOnSubmit(value);
                value.last_reg = DateTime.Now;
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

        // PUT: api/Schools/5
        [HttpPut]
        public void Put([FromUri]string id, school value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                school existingSchool = (from s in items.schools where s.school_id == value.school_id select s).SingleOrDefault();
                existingSchool.address_id = value.address_id;
                existingSchool.approved = value.approved;
                existingSchool.division = value.division;
                existingSchool.last_reg = value.last_reg;
                existingSchool.name = value.name;
                existingSchool.region_id = value.region_id;
                existingSchool.short_name = value.short_name;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Schools/5
        public void Delete(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                school schoolToDelete = (from s in items.schools where s.school_id.ToString() == id select s).First();
                items.schools.DeleteOnSubmit(schoolToDelete);

                items.SubmitChanges();
            }
        }
    }
}
