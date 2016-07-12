using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;

namespace MathIsCool_API.Controllers
{
    public class AddressesController : ApiController
    {
        private MathIsCoolDataContext items = new MathIsCoolDataContext();
        // GET: api/Addresses

        public HttpResponseMessage Options()
        {
            var response = new HttpResponseMessage();
            response.StatusCode = HttpStatusCode.OK;
            return response;
        }

        public IEnumerable<address> Get()
        {
            List<address> addresses = new List<address>();
            foreach (address address in items.addresses)
            {
                addresses.Add(address);
            }
            return addresses;
        }

        // GET: api/Addresses/5
        public IHttpActionResult Get(string id)
        {
            for (int i = 0; i < items.users.Count() - 1; i++)
            {
                foreach (address address in items.addresses)
                {
                    if (id.Equals(address.address_id))
                    {
                        return Ok(address);
                    }
                }
            }

            return NotFound();
        }
        [HttpPost]
        // POST: api/Addresses
        public IHttpActionResult Post([FromBody]address value)
        {
            address addr = new address();
            addr.address_id = value.address_id;
            addr.city = value.city;
            addr.phone = value.phone;
            addr.state = value.state;
            addr.street = value.street;
            addr.zip = value.zip;
            items.addresses.InsertOnSubmit(addr);
            items.SubmitChanges();
            return Ok<bool>(true);
        }

        // PUT: api/Addresses/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Addresses/5
        public void Delete(int id)
        {
        }
    }
}
