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
    public class AnimalController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Animal
        public IQueryable<Animal> GetAnimal()
        {
            return db.Animal;
        }

        // GET: api/Animal/5
        [ResponseType(typeof(Animal))]
        public IHttpActionResult GetAnimal(int id)
        {
            Animal animal = db.Animal.Find(id);
            if (animal == null)
            {
                return NotFound();
            }

            return Ok(animal);
        }

        // PUT: api/Animal/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAnimal(int id, Animal animal)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != animal.Id)
            {
                return BadRequest();
            }

            db.Entry(animal).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AnimalExists(id))
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

        // POST: api/Animal
        [ResponseType(typeof(Animal))]
        public IHttpActionResult PostAnimal(Animal animal)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Animal.Add(animal);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = animal.Id }, animal);
        }

        // DELETE: api/Animal/5
        [ResponseType(typeof(Animal))]
        public IHttpActionResult DeleteAnimal(int id)
        {
            Animal animal = db.Animal.Find(id);
            if (animal == null)
            {
                return NotFound();
            }

            db.Animal.Remove(animal);
            db.SaveChanges();

            return Ok(animal);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AnimalExists(int id)
        {
            return db.Animal.Count(e => e.Id == id) > 0;
        }
    }
}