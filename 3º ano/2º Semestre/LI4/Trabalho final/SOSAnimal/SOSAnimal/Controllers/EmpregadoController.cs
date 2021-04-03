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
    public class EmpregadoController : ApiController
    {
        private SOSAbdEntities1 db = new SOSAbdEntities1();

        // GET: api/Empregado
        public IQueryable<Empregado> GetEmpregado()
        {
            return db.Empregado;
        }

        // GET: api/Empregado/5
        [ResponseType(typeof(Empregado))]
        public IHttpActionResult GetEmpregado(int id)
        {
            Empregado empregado = db.Empregado.Find(id);
            if (empregado == null)
            {
                return NotFound();
            }

            return Ok(empregado);
        }


        //get por email
        // GET: api/Empregado/Em/asd@gmail/ 
        [Route("api/Empregado/Em/{email}/")]
        [ResponseType(typeof(Empregado))]
        [HttpGet]
        public IHttpActionResult GetEmpregadoEmail(string email)
        {
            string query = "SELECT * FROM Empregado WHERE Email = @p0";
            Empregado emp = db.Empregado.SqlQuery(query, email).Single();
            if (emp == null)
            {
                return NotFound();
            }

            return Ok(emp);
        }

        //[ResponseType(typeof(Empregado))]
        [Route("api/Empregado/Login/{email}/{password}")]
        [HttpGet]
        public IHttpActionResult Login(string email, string password)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (!EmpregadoExistsE(email))
            {
                return NotFound();
            }
            if (db.Empregado.Count(e => e.Email.Equals(email) && e.Password.Equals(password)) > 0)
            {
                return StatusCode(HttpStatusCode.OK);
            }
            else
            {
                return StatusCode(HttpStatusCode.Conflict);
            }
        }

        // PUT: api/Empregado/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutEmpregado(int id, Empregado empregado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != empregado.Id)
            {
                return BadRequest();
            }

            db.Entry(empregado).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EmpregadoExists(id))
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

        // POST: api/Empregado
        [ResponseType(typeof(Empregado))]
        public IHttpActionResult PostEmpregado(Empregado empregado)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (EmpregadoExistsE(empregado.Email))
            {
                return StatusCode(HttpStatusCode.Conflict);
            }
            db.Empregado.Add(empregado);
            db.SaveChanges();

            return StatusCode(HttpStatusCode.OK);
        }

        // DELETE: api/Empregado/5
        [ResponseType(typeof(Empregado))]
        public IHttpActionResult DeleteEmpregado(int id)
        {
            Empregado empregado = db.Empregado.Find(id);
            if (empregado == null)
            {
                return NotFound();
            }

            db.Empregado.Remove(empregado);
            db.SaveChanges();

            return Ok(empregado);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool EmpregadoExists(int id)
        {
            return db.Empregado.Count(e => e.Id == id) > 0;
        }

        private bool EmpregadoExistsE(string em)
        {
            return db.Empregado.Count(e => e.Email == em) > 0;
        }
    }
}