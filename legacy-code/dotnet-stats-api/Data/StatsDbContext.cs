using System.Data.Entity;
using PlayerStatsAPI.Models;

namespace PlayerStatsAPI.Data
{
    /// <summary>
    /// Legacy DbContext using Entity Framework 6
    /// BLOCKING I/O - needs migration to EF Core
    /// </summary>
    public class StatsDbContext : DbContext
    {
        public StatsDbContext() : base("name=StatsConnection")
        {
        }

        public DbSet<Player> Players { get; set; }
        public DbSet<MatchHistory> MatchHistories { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure relationships
            modelBuilder.Entity<Player>()
                .HasMany<MatchHistory>(p => p.MatchHistories)
                .WithRequired(m => m.Player)
                .HasForeignKey(m => m.PlayerId)
                .WillCascadeOnDelete(true);
        }
    }
}
