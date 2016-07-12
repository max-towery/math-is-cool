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
    public class SamplesController : ApiController
    {
        // GET: api/Samples
        public IEnumerable<sample> Get()
        {
            List<sample> samples = new List<sample>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                samples = items.samples.ToList();
            }
            return samples;
        }

        // GET: api/Samples/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (sample sample in items.samples)
                {
                    if (id.Equals(sample.sample_id.ToString()))
                    {
                        return Ok(sample);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Samples
        [HttpPost]
        public IHttpActionResult Post(sample value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.samples.InsertOnSubmit(value);
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

        // PUT: api/Samples/5
        [HttpPut]
        public void Put([FromUri]string id, sample value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                sample existingSample = (from s in items.samples where s.sample_id == value.sample_id select s).SingleOrDefault();
                existingSample.comp_level = value.comp_level;
                existingSample.description = value.description;
                existingSample.test_url = value.test_url;
                existingSample.year = value.year;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Samples/5
        public void Delete(int id)
        {
        }
    }
}
