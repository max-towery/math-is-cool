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
    public class NewsController : ApiController
    {
        // GET: api/News
        public IEnumerable<newsItem> Get()
        {
            List<newsItem> newsItems = new List<newsItem>();
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                newsItems = items.newsItems.ToList();
            }
            return newsItems;
        }

        // GET: api/News/5
        public IHttpActionResult Get([FromUri]string id)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                foreach (newsItem news in items.newsItems)
                {
                    if (id.Equals(news.news_id.ToString()))
                    {
                        return Ok(news);
                    }
                }
            }

            return NotFound();
        }

        // POST: api/News
        [HttpPost]
        public IHttpActionResult Post(newsItem value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                items.newsItems.InsertOnSubmit(value);
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

        // PUT: api/News/5
        [HttpPut]
        public void Put([FromUri]string id, newsItem value)
        {
            using (MathIsCoolDataContext items = new MathIsCoolDataContext())
            {
                newsItem existingNews = (from n in items.newsItems where n.news_id == value.news_id select n).SingleOrDefault();
                existingNews.news_content = value.news_content;
                existingNews.priority = value.priority;

                items.SubmitChanges();
            }
        }

        // DELETE: api/News/5
        public void Delete(int id)
        {
        }
    }
}
