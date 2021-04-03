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
    public class VisitaController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Visita
        public IQueryable<Visita> GetVisita()
        {
            return db.Visita;
        }

        // GET: api/Visita/5
        [ResponseType(typeof(Visita))]
        public IHttpActionResult GetVisita(int id)
        {
            Visita visita = db.Visita.Find(id);
            if (visita == null)
            {
                return NotFound();
            }

            return Ok(visita);
        }

        // GET: api/Visita/Uti/5/
        [Route("api/Visita/Uti/{iduser}/")]
        [ResponseType(typeof(Visita))]
        [HttpGet]
        public IHttpActionResult GetVisitaUtilizador(int iduser)
        {
            string query = "SELECT * FROM Visita WHERE IdUser = @p0";
            var vis = db.Visita.SqlQuery(query, iduser).ToList();
            if (vis == null)
            {
                return NotFound();
            }

            return Ok(vis);
        }

        // PUT: api/Visita/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutVisita(int id, Visita visita)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != visita.Id)
            {
                return BadRequest();
            }

            db.Entry(visita).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VisitaExists(id))
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

        // POST: api/Visita
        [ResponseType(typeof(Visita))]
        public IHttpActionResult PostVisita(Visita visita)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Visita.Add(visita);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (VisitaExists(visita.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = visita.Id }, visita);
        }

        // DELETE: api/Visita/5
        [ResponseType(typeof(Visita))]
        public IHttpActionResult DeleteVisita(int id)
        {
            Visita visita = db.Visita.Find(id);
            if (visita == null)
            {
                return NotFound();
            }

            db.Visita.Remove(visita);
            db.SaveChanges();

            return Ok(visita);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool VisitaExists(int id)
        {
            return db.Visita.Count(e => e.Id == id) > 0;
        }
    }
}