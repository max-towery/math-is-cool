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
    public class CompetitionLevelsController : ApiController
    {
        // GET: api/CompetitionLevels
        public IEnumerable<compLevels> Get()
        {
            List<compLevels> levels = new List<compLevels>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                levels = items.compLevels.ToList();
            }
            return levels;
        }

        // GET: api/CompetitionLevels/5
        public IHttpActionResult Get(int id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (comp_level levels in items.comp_levels)
                {
                    if (id == levels.id)
                    {
                        return Ok(levels);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/CompetitionLevels
        [HttpPost]
        public IHttpActionResult Post(comp_level value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.comp_levels.InsertOnSubmit(value);
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

        // PUT: api/CompetitionLevels/5
        [HttpPut]
        public void Put([FromUri]int id, comp_level value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                comp_level existingLevel = (from c in items.comp_levels where c.id == value.id select c).SingleOrDefault();
                existingLevel.value = value.value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/CompetitionLevels/5
        public void Delete(int id)
        {
        }
    }
}
