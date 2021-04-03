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
    public class UtilizadorController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Utilizador
        public IQueryable<Utilizador> GetUtilizador()
        {
            return db.Utilizador;
        }

       
        //get por id
        // GET: api/Utilizador/5  
        [ResponseType(typeof(Utilizador))]
        public IHttpActionResult GetUtilizador(int id)
        {
            Utilizador utilizador = db.Utilizador.Find(id);
            if (utilizador == null)
            {
                return NotFound();
            }

            return Ok(utilizador);
        }

        //get por email
        // GET: api/Utilizador/Em/asd@gmail 
        [Route("api/Utilizador/Em/{email}/")]
        [ResponseType(typeof(Utilizador))]
        [HttpGet]
        public IHttpActionResult GetUtilizadorEmail(string email)
        {
            string query = "SELECT * FROM Utilizador WHERE Email = @p0";
            Utilizador ut = db.Utilizador.SqlQuery(query,email).Single();
            if (ut == null)
            {
                return NotFound();
            }

            return Ok(ut);
        }

        //[ResponseType(typeof(Utilizador))]
        [Route("api/Utilizador/Login/{email}/{password}/")]
        [HttpGet]
        public IHttpActionResult Login(string email, string password)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (!UtilizadorExistsE(email))
            {
                return NotFound();
            }
            //string query = "SELECT * FROM Utilizador WHERE Email = @p0 and Password= @p1";
            //Utilizador ut = db.Utilizador.SqlQuery(query,email,password).Single();
            if (db.Utilizador.Count(e => e.Email.Equals(email) && e.Password.Equals(password)) > 0) {
                return StatusCode(HttpStatusCode.OK);
            }
            else
            {
                return StatusCode(HttpStatusCode.Conflict);
            }
        }

        // PUT: api/Utilizador/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutUtilizador(int id, Utilizador utilizador)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != utilizador.Id)
            {
                return BadRequest();
            }

            db.Entry(utilizador).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UtilizadorExists(id))
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

        // POST: api/Utilizador
        [ResponseType(typeof(Utilizador))]
        [ActionName("Registar")]
        public IHttpActionResult PostUtilizador(Utilizador utilizador)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (UtilizadorExistsE(utilizador.Email))
            {
                return StatusCode(HttpStatusCode.Conflict);
            }

            db.Utilizador.Add(utilizador);
            db.SaveChanges();
           
            return StatusCode(HttpStatusCode.OK);
        }

        // DELETE: api/Utilizador/5
        [ResponseType(typeof(Utilizador))]
        public IHttpActionResult DeleteUtilizador(int id)
        {
            Utilizador utilizador = db.Utilizador.Find(id);
            if (utilizador == null)
            {
                return NotFound();
            }

            db.Utilizador.Remove(utilizador);
            db.SaveChanges();

            return Ok(utilizador);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool UtilizadorExists(int id)
        {
            return db.Utilizador.Count(e => e.Id == id) > 0;
        }

        private bool UtilizadorExistsE(string em)
        {
            return db.Utilizador.Count(e => e.Email.Equals(em)) > 0;
        }
    }
}