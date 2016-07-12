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
    public class FAQController : ApiController
    {
        // GET: api/FAQ
        public IEnumerable<faq> Get()
        {
            List<faq> faqs = new List<faq>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                faqs = items.faqs.ToList();
            }
            return faqs;
        }

        // GET: api/FAQ/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (faq faq in items.faqs)
                {
                    if (id.Equals(faq.faq_id.ToString()))
                    {
                        return Ok(faq);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/FAQ
        [HttpPost]
        public IHttpActionResult Post(faq value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.faqs.InsertOnSubmit(value);
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

        // PUT: api/FAQ/5
        [HttpPut]
        public void Put([FromUri]string id, faq value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                faq existingFAQ = (from f in items.faqs where f.faq_id == value.faq_id select f).SingleOrDefault();
                existingFAQ.question = value.question;
                existingFAQ.answer = value.answer;
                existingFAQ.level = value.level;

                items.SubmitChanges();
            }
        }

        // DELETE: api/FAQ/5
        public void Delete(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                faq faqToDelete = (from u in items.faqs where u.faq_id.ToString() == id select u).First();
                items.faqs.DeleteOnSubmit(faqToDelete);

                items.SubmitChanges();
            }
        }
    }
}
