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
    public class SinalizacaoController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Sinalizacao
        public IQueryable<Sinalizacao> GetSinalizacao()
        {
            return db.Sinalizacao;
        }

        // GET: api/Sinalizacao/5
        [ResponseType(typeof(Sinalizacao))]
        public IHttpActionResult GetSinalizacao(int id)
        {
            Sinalizacao sinalizacao = db.Sinalizacao.Find(id);
            if (sinalizacao == null)
            {
                return NotFound();
            }
            
            return Ok(sinalizacao);
        }

        // GET: api/Sinalizacao/User/5/
        [Route("api/Sinalizacao/User/{iduser}/")]
        [ResponseType(typeof(Sinalizacao))]
        [HttpGet]
        public IHttpActionResult GetSinalizacaoUser(int iduser)
        {
            string query = "SELECT * FROM Sinalizacao WHERE IdUser = @p0";
            var sins = db.Sinalizacao.SqlQuery(query, iduser).ToList();
            if (sins == null)
            {
                return NotFound();
            }

            return Ok(sins);
        }

        // GET: api/Sinalizacao/LastId/Iduser
        [Route("api/Sinalizacao/LastId/{IdUser}/")]
        [ResponseType(typeof(int))]
        [HttpGet]
        public IHttpActionResult GetSinalizacaoLastId(int IdUser)
        {
            var id = db.Sinalizacao.Where(p=> p.IdUser==IdUser).ToList().Last().Id;

            return Ok(id);
        }

        // PUT: api/Sinalizacao/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutSinalizacao(int id, Sinalizacao sinalizacao)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != sinalizacao.Id)
            {
                return BadRequest();
            }

            db.Entry(sinalizacao).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SinalizacaoExists(id))
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

        // POST: api/Sinalizacao
        [ResponseType(typeof(Sinalizacao))]
        public IHttpActionResult PostSinalizacao(Sinalizacao sinalizacao)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Sinalizacao.Add(sinalizacao);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (SinalizacaoExists(sinalizacao.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.OK);
        }

        // DELETE: api/Sinalizacao/5
        [ResponseType(typeof(Sinalizacao))]
        public IHttpActionResult DeleteSinalizacao(int id)
        {
            Sinalizacao sinalizacao = db.Sinalizacao.Find(id);
            if (sinalizacao == null)
            {
                return NotFound();
            }

            db.Sinalizacao.Remove(sinalizacao);
            db.SaveChanges();

            return Ok(sinalizacao);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SinalizacaoExists(int id)
        {
            return db.Sinalizacao.Count(e => e.Id == id) > 0;
        }
    }
}