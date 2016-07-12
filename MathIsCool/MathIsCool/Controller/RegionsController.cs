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
    public class RegionsController : ApiController
    {
        // GET: api/Regions
        public IEnumerable<region> Get()
        {
            List<region> regions = new List<region>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                regions = items.regions.ToList();
            }
            return regions;
        }

        // GET: api/Regions/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (region region in items.regions)
                {
                    if (id.Equals(region.region_id.ToString()))
                    {
                        return Ok(region);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Regions
        [HttpPost]
        public IHttpActionResult Post(region value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.regions.InsertOnSubmit(value);
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

        // PUT: api/Regions/5
        [HttpPut]
        public void Put([FromUri]string id, region value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                region existingRegion = (from r in items.regions where r.region_id == value.region_id select r).SingleOrDefault();
                existingRegion.region_name = value.region_name;
                existingRegion.user_id = value.user_id;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Regions/5
        public void Delete(int id)
        {
        }
    }
}
