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
    public class StudentsController : ApiController
    {
        // GET: api/Students
        public IEnumerable<student> Get()
        {
            List<student> students = new List<student>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                students = items.students.ToList();
            }
            return students;
        }

        // GET: api/Students/5
        public IHttpActionResult Get(string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (student student in items.students)
                {
                    if (id.Equals(student.student_id.ToString()))
                    {
                        return Ok(student);
                    }
                }
            }

            return NotFound();
        } 

        // POST: api/Students
        [HttpPost]
        public IHttpActionResult Post(student value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.students.InsertOnSubmit(value);
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

        // PUT: api/Students/5
        [HttpPut]
        public void Put([FromUri]string id, student value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                student existingStutdent = (from s in items.students where s.student_id == value.student_id select s).SingleOrDefault();
                existingStutdent.fname = value.fname;
                existingStutdent.lname = value.lname;
                existingStutdent.ind_num = value.ind_num;
                existingStutdent.student_level = value.student_level;
                existingStutdent.team_id = value.team_id;

                items.SubmitChanges();
            }
        }

        // DELETE: api/Students/5
        public void Delete(int id)
        {
        }
    }
}
