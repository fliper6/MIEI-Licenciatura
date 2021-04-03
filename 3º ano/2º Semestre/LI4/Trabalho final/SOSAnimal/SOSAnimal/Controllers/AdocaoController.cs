using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using SOSAnimal.Models;

namespace SOSAnimal.Controllers
{
    public class AdocaoController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Adocao
        public IQueryable<Adocao> GetAdocao()
        {
            return db.Adocao;
        }

        // GET: api/Adocao/5
        [ResponseType(typeof(Adocao))]
        public IHttpActionResult GetAdocao(int id)
        {
            Adocao adocao = db.Adocao.Find(id);
            if (adocao == null)
            {
                return NotFound();
            }

            return Ok(adocao);
        }

        // PUT: api/Adocao/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAdocao(int id, Adocao adocao)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != adocao.Id)
            {
                return BadRequest();
            }

            db.Entry(adocao).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AdocaoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Adocao
        [ResponseType(typeof(Adocao))]
        public IHttpActionResult PostAdocao(Adocao adocao)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Adocao.Add(adocao);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (AdocaoExists(adocao.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = adocao.Id }, adocao);
        }

        // DELETE: api/Adocao/5
        [ResponseType(typeof(Adocao))]
        public IHttpActionResult DeleteAdocao(int id)
        {
            Adocao adocao = db.Adocao.Find(id);
            if (adocao == null)
            {
                return NotFound();
            }

            db.Adocao.Remove(adocao);
            db.SaveChanges();

            return Ok(adocao);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AdocaoExists(int id)
        {
            return db.Adocao.Count(e => e.Id == id) > 0;
        }
    }
}