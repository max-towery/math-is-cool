using MathIsCool.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.UI;

namespace MathIsCool.Controller
{
    public class AddressesController : ApiController
    {
        // GET: api/Addresses
        public IEnumerable<address> Get()
        {
            List<address> addresses = new List<address>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                addresses = items.addresses.ToList();
            }
            return addresses;
        }

        // GET: api/Addresses/5
        public IHttpActionResult Get([FromUri]string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (address address in items.addresses)
                {
                    if (id.Equals(address.address_id.ToString()))
                    {
                        return Ok(address);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Addresses
        [HttpPost]
        public IHttpActionResult Post(address value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.addresses.InsertOnSubmit(value);
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

        // PUT: api/Addresses/5
        [HttpPut]
        public void Put([FromUri]string id, address value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                address existingAddress = (from a in items.addresses where a.address_id == value.address_id select a).SingleOrDefault();
                existingAddress.street = value.street;
                existingAddress.city = value.city;
                existingAddress.zip = value.zip;
                existingAddress.phone = value.phone;
                existingAddress.extension = value.extension;
                existingAddress.state = value.state;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Addresses/5
        public void Delete(int id)
        {
        }
    }
}
