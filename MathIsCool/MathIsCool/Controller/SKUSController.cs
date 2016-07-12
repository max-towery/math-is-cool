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
    public class SKUSController : ApiController
    {
        // GET: api/SKUS
        public IEnumerable<sku> Get()
        {
            List<sku> skus = new List<sku>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                skus = items.skus.ToList();
            }
            return skus;
        }

        // GET: api/SKUS/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (sku sku in items.skus)
                {
                    if (id.Equals(sku.sku_id.ToString()))
                    {
                        return Ok(sku);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/SKUS
        [HttpPost]
        public IHttpActionResult Post(sku value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.skus.InsertOnSubmit(value);
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

        // PUT: api/SKUS/5
        [HttpPut]
        public void Put([FromUri]string id, sku value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                sku existingSKU = (from s in items.skus where s.sku_id == value.sku_id select s).SingleOrDefault();
                existingSKU.description = value.description;

                items.SubmitChanges();
            }
        }

        // DELETE: api/SKUS/5
        public void Delete(int id)
        {
        }
    }
}
