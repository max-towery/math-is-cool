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
    public class LineItemsController : ApiController
    {
        // GET: api/LineItems
        public IEnumerable<line_item> Get()
        {
            List<line_item> lineItems = new List<line_item>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                lineItems = items.line_items.ToList();
            }
            return lineItems;
        }

        // GET: api/LineItems/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (line_item lineItem in items.line_items)
                {
                    if (id.Equals(lineItem.line_item_id.ToString()))
                    {
                        return Ok(lineItem);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/LineItems
        [HttpPost]
        public IHttpActionResult Post(line_item value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.line_items.InsertOnSubmit(value);
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

        // PUT: api/LineItems/5
        [HttpPut]
        public void Put([FromUri]string id, line_item value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                line_item existingLineItem = (from l in items.line_items where l.line_item_id == value.line_item_id select l).SingleOrDefault();
                existingLineItem = value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/LineItems/5
        public void Delete(int id)
        {
        }
    }
}
