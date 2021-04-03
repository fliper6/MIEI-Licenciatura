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
    public class ImagemAnimalController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/ImagemAnimal
        public IQueryable<ImagemAnimal> GetImagemAnimal()
        {
            return db.ImagemAnimal;
        }

        // GET: api/ImagemAnimal/5
        [ResponseType(typeof(ImagemAnimal))]
        public IHttpActionResult GetImagemAnimal(int id)
        {
            ImagemAnimal imagemAnimal = db.ImagemAnimal.Find(id);
            if (imagemAnimal == null)
            {
                return NotFound();
            }

            return Ok(imagemAnimal);
        }

        // GET: api/ImagemAnimal/Ani/5/
        [Route("api/ImagemAnimal/Ani/{idAni}/")]
        [ResponseType(typeof(ImagemAnimal))]
        [HttpGet]
        public IHttpActionResult GetImagensSin(int idAni)
        {
            string query = "SELECT * FROM ImagemAnimal WHERE IdAnimal = @p0";
            var imgs = db.ImagemAnimal.SqlQuery(query, idAni).ToList();
            if (imgs == null)
            {
                return NotFound();
            }

            return Ok(imgs);
        }

        // PUT: api/ImagemAnimal/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutImagemAnimal(int id, ImagemAnimal imagemAnimal)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != imagemAnimal.Id)
            {
                return BadRequest();
            }

            db.Entry(imagemAnimal).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ImagemAnimalExists(id))
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

        // POST: api/ImagemAnimal
        [ResponseType(typeof(ImagemAnimal))]
        public IHttpActionResult PostImagemAnimal(ImagemAnimal imagemAnimal)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ImagemAnimal.Add(imagemAnimal);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = imagemAnimal.Id }, imagemAnimal);
        }

        // DELETE: api/ImagemAnimal/5
        [ResponseType(typeof(ImagemAnimal))]
        public IHttpActionResult DeleteImagemAnimal(int id)
        {
            ImagemAnimal imagemAnimal = db.ImagemAnimal.Find(id);
            if (imagemAnimal == null)
            {
                return NotFound();
            }

            db.ImagemAnimal.Remove(imagemAnimal);
            db.SaveChanges();

            return Ok(imagemAnimal);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ImagemAnimalExists(int id)
        {
            return db.ImagemAnimal.Count(e => e.Id == id) > 0;
        }
    }
}