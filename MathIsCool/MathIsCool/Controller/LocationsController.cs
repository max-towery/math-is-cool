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
    public class LocationsController : ApiController
    {
        // GET: api/Locations
        public IEnumerable<location> Get()
        {
            List<location> locations = new List<location>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                locations = items.locations.ToList();
            }
            return locations;
            
        }



        // GET: api/Locations/LocationByRegionID/?regionID= id
        //[Route("Locations/LocationByRegionID/{regionID}")]
        //public IEnumerable<location> LocationByRegionID(string regionID)
        //{
        //    List<location> locations = new List<location>();
        //    foreach (location comp_location in items.locations)
        //    {
        //        if (comp_location.region_id.ToString().ToLower().Equals(regionID.ToLower()))
        //        {
        //            locations.Add(comp_location);
        //        }
        //    }
        //    return locations;
        //}

        // GET: api/Locations/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (comp_location location in items.comp_locations)
                {
                    if (id.Equals(location.comp_loc_id.ToString()))
                    {
                        return Ok(location);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/Locations
        [HttpPost]
        public IHttpActionResult Post(comp_location value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                
                try
                {
                    items.comp_locations.InsertOnSubmit(value);
                    items.SubmitChanges();
                    return Ok(value);
                }
                catch (Exception e)
                {
                    return NotFound();
                }
            }
        }

        // PUT: api/Locations/5
        [HttpPut]
        public void Put([FromUri]string id, comp_location value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                comp_location existingLocation = (from l in items.comp_locations where l.comp_loc_id == value.comp_loc_id select l).SingleOrDefault();
                existingLocation.name = value.name;
                existingLocation.region_id = value.region_id;
                existingLocation.address_id = value.address_id;
                existingLocation.map_url = value.map_url;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Locations/5
        public void Delete(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                comp_location compLocToDelete = (from l in items.comp_locations where l.comp_loc_id.ToString() == id select l).First();
                items.comp_locations.DeleteOnSubmit(compLocToDelete);

                items.SubmitChanges();
            }
        }
    }
}
