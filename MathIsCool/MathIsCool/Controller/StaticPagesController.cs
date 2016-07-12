using MathIsCool.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MathIsCool.Controller
{
    public class StaticPagesController : ApiController
    {
        // GET: api/StaticPages
        public IEnumerable<static_page> Get()
        {
            List<static_page> pages = new List<static_page>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                pages = items.static_pages.ToList();
            }
            return pages;
        }
        //api/StaticPages?type=about
        // GET: api/StaticPages/5
        public IHttpActionResult Get([FromUri]string type)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (static_page page in items.static_pages)
                {
                    if (type.Equals(page.type))
                    {
                        return Ok(page);
                    }
                }
            }

            return NotFound();

        }

        // POST: api/StaticPages
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/StaticPages/5
        [HttpPut]
        public void Put([FromUri] string type, [FromBody] static_page value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                static_page existingstaticPage = (from s in items.static_pages where s.type == type select s).SingleOrDefault();
                existingstaticPage.description = value.description;

                items.SubmitChanges();
            }
        }

        // DELETE: api/StaticPages/5
        public void Delete(int id)
        {
        }
    }
}
