using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using PlayerStatsAPI.Data;
using PlayerStatsAPI.Models;

namespace PlayerStatsAPI.Controllers
{
    /// <summary>
    /// Legacy Web API 2 Controller
    /// BLOCKING operations - needs migration to minimal APIs
    /// </summary>
    [RoutePrefix("api/players")]
    public class PlayersController : ApiController
    {
        private StatsDbContext db = new StatsDbContext();

        // GET: api/players
        [HttpGet]
        [Route("")]
        public IHttpActionResult GetAllPlayers()
        {
            try
            {
                var players = db.Players.ToList();
                return Ok(players);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // GET: api/players/5
        [HttpGet]
        [Route("{id:int}")]
        public IHttpActionResult GetPlayer(int id)
        {
            try
            {
                var player = db.Players.Find(id);
                if (player == null)
                {
                    return NotFound();
                }
                return Ok(player);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // POST: api/players
        [HttpPost]
        [Route("")]
        public IHttpActionResult CreatePlayer([FromBody] Player player)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                db.Players.Add(player);
                db.SaveChanges();
                return Created($"api/players/{player.Id}", player);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // PUT: api/players/5
        [HttpPut]
        [Route("{id:int}")]
        public IHttpActionResult UpdatePlayer(int id, [FromBody] Player updatedPlayer)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var player = db.Players.Find(id);
                if (player == null)
                {
                    return NotFound();
                }

                player.Username = updatedPlayer.Username;
                player.Email = updatedPlayer.Email;
                player.TotalMatches = updatedPlayer.TotalMatches;
                player.Wins = updatedPlayer.Wins;
                player.Losses = updatedPlayer.Losses;
                player.EloRating = updatedPlayer.EloRating;
                player.LastActiveAt = DateTime.UtcNow;

                db.SaveChanges();
                return Ok(player);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // DELETE: api/players/5
        [HttpDelete]
        [Route("{id:int}")]
        public IHttpActionResult DeletePlayer(int id)
        {
            try
            {
                var player = db.Players.Find(id);
                if (player == null)
                {
                    return NotFound();
                }

                db.Players.Remove(player);
                db.SaveChanges();
                return StatusCode(HttpStatusCode.NoContent);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        // GET: api/players/leaderboard
        [HttpGet]
        [Route("leaderboard")]
        public IHttpActionResult GetLeaderboard(int limit = 10)
        {
            try
            {
                var topPlayers = db.Players
                    .OrderByDescending(p => p.EloRating)
                    .Take(limit)
                    .ToList();
                return Ok(topPlayers);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
