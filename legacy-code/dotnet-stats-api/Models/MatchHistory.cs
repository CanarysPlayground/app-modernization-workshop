using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlayerStatsAPI.Models
{
    [Table("MatchHistories")]
    public class MatchHistory
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int PlayerId { get; set; }

        [Required]
        [MaxLength(100)]
        public string Game { get; set; }

        [Required]
        public DateTime MatchDate { get; set; }

        public bool IsWin { get; set; }

        public int Score { get; set; }

        [MaxLength(50)]
        public string Rank { get; set; }

        [ForeignKey("PlayerId")]
        public virtual Player Player { get; set; }
    }
}
