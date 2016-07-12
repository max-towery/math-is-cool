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
    public class StatusesController : ApiController
    {
        // GET: api/Statuses
        public IEnumerable<statuses> Get()
        {
            List<statuses> statuses = new List<statuses>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                statuses = items.statuses.ToList();
            }
            return statuses;
        }

        // GET: api/Statuses/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (status status in items.status)
                {
                    if (id.Equals(status.id.ToString()))
                    {
                        return Ok(status);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Statuses
        [HttpPost]
        public IHttpActionResult Post(status value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.status.InsertOnSubmit(value);
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

        // PUT: api/Statuses/5
        [HttpPut]
        public void Put(int id, status value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                status existingStatus = (from s in items.status where s.id == value.id select s).SingleOrDefault();
                existingStatus.value = value.value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Statuses/5
        public void Delete(int id)
        {
        }
    }
}
