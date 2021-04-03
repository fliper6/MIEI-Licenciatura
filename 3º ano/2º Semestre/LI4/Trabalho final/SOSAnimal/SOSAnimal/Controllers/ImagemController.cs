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
    public class ImagemController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Imagem
        public IQueryable<Imagem> GetImagem()
        {
            return db.Imagem;
        }

        // GET: api/Imagem/5
        [ResponseType(typeof(Imagem))]
        public IHttpActionResult GetImagem(int id)
        {
            Imagem imagem = db.Imagem.Find(id);
            if (imagem == null)
            {
                return NotFound();
            }

            return Ok(imagem);
        }

        // GET: api/Imagem/Sin/5/
        [Route("api/Imagem/Sin/{idSina}/")]
        [ResponseType(typeof(Imagem))]
        [HttpGet]
        public IHttpActionResult GetImagensSin(int idSina)
        {
            string query = "SELECT * FROM Imagem WHERE IdSinalizacao = @p0";
            var imgs = db.Imagem.SqlQuery(query, idSina).ToList();
            if (imgs == null)
            {
                return NotFound();
            }

            return Ok(imgs);
        }

        // PUT: api/Imagem/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutImagem(int id, Imagem imagem)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != imagem.Id)
            {
                return BadRequest();
            }

            db.Entry(imagem).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ImagemExists(id))
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

        // POST: api/Imagem
        [ResponseType(typeof(Imagem))]
        public IHttpActionResult PostImagem(Imagem imagem)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Imagem.Add(imagem);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = imagem.Id }, imagem);
        }

        // DELETE: api/Imagem/5
        [ResponseType(typeof(Imagem))]
        public IHttpActionResult DeleteImagem(int id)
        {
            Imagem imagem = db.Imagem.Find(id);
            if (imagem == null)
            {
                return NotFound();
            }

            db.Imagem.Remove(imagem);
            db.SaveChanges();

            return Ok(imagem);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ImagemExists(int id)
        {
            return db.Imagem.Count(e => e.Id == id) > 0;
        }
    }
}