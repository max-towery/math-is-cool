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
    public class InvoicesController : ApiController
    {
        // GET: api/Invoice
        public IEnumerable<invoice> Get()
        {
            List<invoice> invoices = new List<invoice>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                invoices = items.invoices.ToList();
            }
            return invoices;
        }

        // GET: api/Invoice/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (invoice invoice in items.invoices)
                {
                    if (id.Equals(invoice.invoice_id.ToString()))
                    {
                        return Ok(invoice);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Invoice
        [HttpPost]
        public IHttpActionResult Post(invoice value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.invoices.InsertOnSubmit(value);
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

        // PUT: api/Invoice/5
        [HttpPut]
        public void Put([FromUri]string id, invoice value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                invoice existingInvoice = (from i in items.invoices where i.invoice_id == value.invoice_id select i).SingleOrDefault();
                existingInvoice = value;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Invoice/5
        public void Delete(int id)
        {
        }
    }
}
