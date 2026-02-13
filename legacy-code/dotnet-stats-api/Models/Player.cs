using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlayerStatsAPI.Models
{
    /// <summary>
    /// Legacy Player model using Entity Framework 6
    /// Uses .NET Framework 4.8 - NEEDS MIGRATION
    /// </summary>
    [Table("Players")]
    public class Player
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(100)]
        public string Username { get; set; }

        [Required]
        [EmailAddress]
        public string Email { get; set; }

        public int TotalMatches { get; set; }

        public int Wins { get; set; }

        public int Losses { get; set; }

        [NotMapped]
        public decimal WinRate
        {
            get
            {
                return TotalMatches > 0 ? (decimal)Wins / TotalMatches * 100 : 0;
            }
        }

        public int EloRating { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime? LastActiveAt { get; set; }

        public Player()
        {
            CreatedAt = DateTime.UtcNow;
            EloRating = 1000;
        }
    }
}
