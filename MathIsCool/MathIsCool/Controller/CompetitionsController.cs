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
    public class CompetitionsController : ApiController
    {
        // GET: api/Competitions
        public IEnumerable<competitions> Get()
        {
            List<competitions> competitions = new List<competitions>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                competitions = items.competitions1.ToList();
            }
            return competitions;
        }

        // GET: api/Competitions/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (competition competition in items.competitions)
                {
                    if (id.Equals(competition.comp_id.ToString()))
                    {
                        return Ok(competition);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Competitions
        [HttpPost]
        public IHttpActionResult Post(competition value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.competitions.InsertOnSubmit(value);
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

        // PUT: api/Competitions/5
        [HttpPut]
        public void Put([FromUri]string id, competitions value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                competition existingComp = (from c in items.competitions where c.comp_id == value.comp_id select c).SingleOrDefault();
                existingComp.name = value.name;
                existingComp.comp_loc_id = value.comp_loc_id;
                existingComp.level_id = value.level_id;
                existingComp.status_id = value.status_id;
                existingComp.note = value.note;
                existingComp.team_limit = value.team_limit;
                existingComp.date = value.date;
                existingComp.region_id = value.region_id;
                existingComp.schedule = value.schedule;
                existingComp.student_limit = value.student_limit;
                existingComp.total_teams_allowed = value.total_teams_allowed;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Competitions/5
        public void Delete(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                competition compToDelete = (from c in items.competitions where c.comp_id.ToString() == id select c).First();
                items.competitions.DeleteOnSubmit(compToDelete);

                items.SubmitChanges();
            }
        }
    }
}
