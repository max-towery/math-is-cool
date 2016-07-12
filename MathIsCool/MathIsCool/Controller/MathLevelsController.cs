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
    public class MathLevelsController : ApiController
    {
        // GET: api/StudentLevels
        public IEnumerable<math_level> Get()
        {
            List<math_level> levels = new List<math_level>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                levels = items.math_levels.ToList();
            }
            return levels;
        }

        // GET: api/StudentLevels/5
        public IHttpActionResult Get(int id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (math_level level in items.math_levels)
                {
                    if (id == level.id)
                    {
                        return Ok(level);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/StudentLevels
        [HttpPost]
        public IHttpActionResult Post(math_level value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.math_levels.InsertOnSubmit(value);
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

        // PUT: api/StudentLevels/5
        [HttpPut]
        public void Put([FromUri]int id, math_level value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                math_level existingStuLevel = (from s in items.math_levels where s.id == value.id select s).SingleOrDefault();
                existingStuLevel.value = value.value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/StudentLevels/5
        public void Delete(int id)
        {
        }
    }
}
