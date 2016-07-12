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
    public class CalendarController : ApiController
    {
        // GET: api/Calendar
        public IEnumerable<calendar> Get()
        {
            List<calendar> calendars = new List<calendar>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                calendars = items.calendars.ToList();
            }
            return calendars;
        }

        // GET: api/Calendar/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (calendar calendar in items.calendars)
                {
                    if (id.Equals(calendar.cal_id.ToString()))
                    {
                        return Ok(calendar);
                    }
                }
            }
            return NotFound();
        }

        // POST: api/Calendar
        [HttpPost]
        public IHttpActionResult Post(calendar value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.calendars.InsertOnSubmit(value);
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

        // PUT: api/Calendar/5
        [HttpPut]
        public void Put([FromUri]string id, calendar value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                calendar existingCalendar = (from c in items.calendars where c.cal_id == value.cal_id select c).SingleOrDefault();
                existingCalendar.date = value.date;
                existingCalendar.@event = value.@event;
                existingCalendar.min_priv = value.min_priv;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Calendar/5
        public void Delete(int id)
        {
        }
    }
}
