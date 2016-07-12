using MathIsCool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MathIsCool.Controller
{
    public class CompetitionCalendarController : ApiController
    {

        // GET: api/CompetitionCalendar
        public IEnumerable<CalendarCompetition> Get()
        {
            List<CalendarCompetition> competitions = new List<CalendarCompetition>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                competitions = items.CalendarCompetitions.ToList();
            }
            return competitions;
        }

        // GET: api/CompetitionCalendar/5
        public string Get(int id)
        {
            return "value";
        }

        // POST: api/CompetitionCalendar
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/CompetitionCalendar/5
        public void Put([FromUri]string id, CalendarCompetition value)
        {

        }

        // DELETE: api/CompetitionCalendar/5
        public void Delete(int id)
        {
        }
    }
}
