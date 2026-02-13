# Exercise 2: .NET Player Stats API Modernization ⚡

**Duration**: 30 minutes  
**Difficulty**: ⭐⭐⭐ Intermediate  
**Prerequisites**: .NET 8.0 SDK, Visual Studio Code, GitHub Copilot enabled

## 🎮 The Challenge

The **Player Stats API** tracks player performance, rankings, match history, and achievements across all Game Arena Legends tournaments. Built in 2014 with **.NET Framework 4.8**, it's struggling to keep up:

- 🐌 Legacy WCF services and SOAP endpoints
- 📦 Entity Framework with slow LINQ queries
- 🔧 No support for modern minimal APIs
- 🚫 Cannot deploy to containers or cloud-native platforms
- ⚠️ Security vulnerabilities in old .NET Framework

Your mission: **Migrate to .NET 8 with minimal APIs, Entity Framework Core, and cloud-ready architecture.**

## 📋 What You'll Learn

- ✅ Migrate .NET Framework 4.8 → .NET 8
- ✅ Convert Web API controllers to minimal APIs
- ✅ Update Entity Framework → Entity Framework Core
- ✅ Implement Native AOT compilation for faster startup
- ✅ Add OpenAPI/Swagger documentation
- ✅ Use GitHub Copilot agents for .NET migration

## 🏗️ Architecture Overview

**Before (Legacy):**
```
.NET Framework 4.8
├── ASP.NET Web API 2
├── Entity Framework 6
├── Full .NET Runtime (Windows only)
└── IIS Hosting
```

**After (Modernized):**
```
.NET 8
├── Minimal APIs
├── Entity Framework Core
├── Cross-platform runtime
└── Kestrel + Docker
```

## 🚀 Step-by-Step Guide

### Step 1: Assess the Legacy Code (5 minutes)

1. Navigate to the legacy code:
```bash
cd legacy-code/dotnet-stats-api
```

2. Examine the project structure:
```
PlayerStatsAPI/
├── PlayerStatsAPI.csproj (Framework 4.8)
├── Controllers/
│   └── PlayersController.cs
├── Models/
│   ├── Player.cs
│   └── MatchHistory.cs
├── Data/
│   └── StatsDbContext.cs
└── Web.config
```

3. **Use GitHub Copilot App Modernization Extension for .NET:**

**Method 1: Right-click menu**
- Right-click on the project folder or `.csproj` file
- Select "Copilot: Assess for .NET Modernization"
- Review the automated assessment

**Method 2: Chat command**

Open Copilot Chat and run:
```
@workspace /agent AppModernization-DotNet assess this .NET project for migration to .NET 8
```

**Expected Assessment Report:**
- Current .NET Framework version detected
- Target framework recommendation (.NET 8)
- List of incompatible packages
- API compatibility issues
- Estimated migration effort

4. Review the assessment output:
   - [ ] .NET Framework 4.8 detected
   - [ ] Entity Framework 6 needs migration to EF Core
   - [ ] Web API controllers can be simplified to minimal APIs
   - [ ] System.Web dependencies must be replaced

### Step 2: Create New .NET 8 Project (5 minutes)

1. **Create a new .NET 8 Web API project:**

```bash
cd ../..
mkdir modernized-code/dotnet-stats-api
cd modernized-code/dotnet-stats-api

dotnet new webapi -n PlayerStatsAPI -f net8.0
cd PlayerStatsAPI
```

2. **Add required packages:**

```bash
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.InMemory
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Swashbuckle.AspNetCore
```

3. **Verify the new project:**

```bash
dotnet build
dotnet run
```

Expected output:
```
Now listening on: http://localhost:5000
```

### Step 3: Migrate Data Models (5 minutes)

1. **Create the Player model:**

Use Copilot to migrate the legacy model:

Press `Ctrl+I` and ask:
```
Convert this .NET Framework Entity Framework 6 model to .NET 8 Entity Framework Core
```

**Modern Player.cs:**
```csharp
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlayerStatsAPI.Models;

[Table("Players")]
public class Player
{
    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Username { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Range(0, int.MaxValue)]
    public int TotalMatches { get; set; }

    [Range(0, int.MaxValue)]
    public int Wins { get; set; }

    [Range(0, int.MaxValue)]
    public int Losses { get; set; }

    [Column(TypeName = "decimal(18,2)")]
    public decimal WinRate => TotalMatches > 0 ? (decimal)Wins / TotalMatches * 100 : 0;

    [Range(0, 5000)]
    public int EloRating { get; set; } = 1000;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    
    public DateTime? LastActiveAt { get; set; }

    // Navigation property
    public ICollection<MatchHistory> MatchHistories { get; set; } = new List<MatchHistory>();
}
```

2. **Create MatchHistory model:**

```csharp
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PlayerStatsAPI.Models;

[Table("MatchHistories")]
public class MatchHistory
{
    [Key]
    public int Id { get; set; }

    [Required]
    public int PlayerId { get; set; }

    [Required]
    [MaxLength(100)]
    public string Game { get; set; } = string.Empty;

    [Required]
    public DateTime MatchDate { get; set; }

    [Required]
    public bool IsWin { get; set; }

    [Range(0, int.MaxValue)]
    public int Score { get; set; }

    [MaxLength(50)]
    public string Rank { get; set; } = string.Empty;

    // Navigation property
    [ForeignKey(nameof(PlayerId))]
    public Player? Player { get; set; }
}
```

### Step 4: Migrate DbContext to EF Core (5 minutes)

**Modern StatsDbContext.cs:**

```csharp
using Microsoft.EntityFrameworkCore;
using PlayerStatsAPI.Models;

namespace PlayerStatsAPI.Data;

public class StatsDbContext : DbContext
{
    public StatsDbContext(DbContextOptions<StatsDbContext> options)
        : base(options)
    {
    }

    public DbSet<Player> Players => Set<Player>();
    public DbSet<MatchHistory> MatchHistories => Set<MatchHistory>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Configure relationships
        modelBuilder.Entity<Player>()
            .HasMany(p => p.MatchHistories)
            .WithOne(m => m.Player)
            .HasForeignKey(m => m.PlayerId)
            .OnDelete(DeleteBehavior.Cascade);

        // Seed data
        modelBuilder.Entity<Player>().HasData(
            new Player
            {
                Id = 1,
                Username = "ProGamer123",
                Email = "pro@gamearena.com",
                TotalMatches = 150,
                Wins = 95,
                Losses = 55,
                EloRating = 1850,
                CreatedAt = DateTime.UtcNow.AddMonths(-6)
            },
            new Player
            {
                Id = 2,
                Username = "EliteSniper",
                Email = "sniper@gamearena.com",
                TotalMatches = 200,
                Wins = 140,
                Losses = 60,
                EloRating = 2100,
                CreatedAt = DateTime.UtcNow.AddYears(-1)
            }
        );
    }
}
```

### Step 5: Convert to Minimal APIs (10 minutes)

This is the biggest modernization step!

**Modern Program.cs with Minimal APIs:**

```csharp
using Microsoft.EntityFrameworkCore;
using PlayerStatsAPI.Data;
using PlayerStatsAPI.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configure database (using in-memory for demo)
builder.Services.AddDbContext<StatsDbContext>(options =>
    options.UseInMemoryDatabase("GameArenaStats"));

// Enable CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// Configure middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowAll");
app.UseHttpsRedirection();

// Seed database
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<StatsDbContext>();
    dbContext.Database.EnsureCreated();
}

// ===== MINIMAL API ENDPOINTS =====

// Get all players
app.MapGet("/api/players", async (StatsDbContext db) =>
{
    var players = await db.Players
        .Include(p => p.MatchHistories)
        .ToListAsync();
    return Results.Ok(players);
})
.WithName("GetAllPlayers")
.WithOpenApi();

// Get player by ID
app.MapGet("/api/players/{id:int}", async (int id, StatsDbContext db) =>
{
    var player = await db.Players
        .Include(p => p.MatchHistories)
        .FirstOrDefaultAsync(p => p.Id == id);

    return player is not null ? Results.Ok(player) : Results.NotFound();
})
.WithName("GetPlayerById")
.WithOpenApi();

// Create player
app.MapPost("/api/players", async (Player player, StatsDbContext db) =>
{
    db.Players.Add(player);
    await db.SaveChangesAsync();
    return Results.Created($"/api/players/{player.Id}", player);
})
.WithName("CreatePlayer")
.WithOpenApi();

// Update player
app.MapPut("/api/players/{id:int}", async (int id, Player updatedPlayer, StatsDbContext db) =>
{
    var player = await db.Players.FindAsync(id);
    if (player is null) return Results.NotFound();

    player.Username = updatedPlayer.Username;
    player.Email = updatedPlayer.Email;
    player.TotalMatches = updatedPlayer.TotalMatches;
    player.Wins = updatedPlayer.Wins;
    player.Losses = updatedPlayer.Losses;
    player.EloRating = updatedPlayer.EloRating;
    player.LastActiveAt = DateTime.UtcNow;

    await db.SaveChangesAsync();
    return Results.Ok(player);
})
.WithName("UpdatePlayer")
.WithOpenApi();

// Delete player
app.MapDelete("/api/players/{id:int}", async (int id, StatsDbContext db) =>
{
    var player = await db.Players.FindAsync(id);
    if (player is null) return Results.NotFound();

    db.Players.Remove(player);
    await db.SaveChangesAsync();
    return Results.NoContent();
})
.WithName("DeletePlayer")
.WithOpenApi();

// Get top players by ELO rating
app.MapGet("/api/players/leaderboard", async (int limit, StatsDbContext db) =>
{
    var topPlayers = await db.Players
        .OrderByDescending(p => p.EloRating)
        .Take(limit > 0 ? limit : 10)
        .ToListAsync();
    return Results.Ok(topPlayers);
})
.WithName("GetLeaderboard")
.WithOpenApi();

// Get player statistics summary
app.MapGet("/api/players/{id:int}/stats", async (int id, StatsDbContext db) =>
{
    var player = await db.Players.FindAsync(id);
    if (player is null) return Results.NotFound();

    var stats = new
    {
        player.Username,
        player.TotalMatches,
        player.Wins,
        player.Losses,
        WinRate = $"{player.WinRate:F2}%",
        player.EloRating,
        Rank = player.EloRating switch
        {
            >= 2000 => "Master",
            >= 1800 => "Diamond",
            >= 1500 => "Platinum",
            >= 1200 => "Gold",
            _ => "Silver"
        }
    };

    return Results.Ok(stats);
})
.WithName("GetPlayerStats")
.WithOpenApi();

// Health check
app.MapGet("/health", () => Results.Ok(new { status = "healthy", service = "PlayerStatsAPI", version = "2.0" }))
.WithName("HealthCheck")
.WithOpenApi();

app.Run();
```

### Step 6: Configure for Native AOT (Optional - 2 minutes)

Enable Native AOT for faster startup:

**Update PlayerStatsAPI.csproj:**

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <PublishAot>true</PublishAot>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.EntityFrameworkCore.InMemory" Version="8.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="8.0.0" />
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
  </ItemGroup>
</Project>
```

### Step 7: Test the Modernized API (3 minutes)

1. **Run the application:**

```bash
dotnet run
```

2. **Open Swagger UI:**

Navigate to: `http://localhost:5000/swagger`

3. **Test endpoints with curl:**

```bash
# Get all players
curl http://localhost:5000/api/players

# Get player by ID
curl http://localhost:5000/api/players/1

# Create a player
curl -X POST http://localhost:5000/api/players \
  -H "Content-Type: application/json" \
  -d '{
    "username": "NewChampion",
    "email": "champion@gamearena.com",
    "totalMatches": 0,
    "wins": 0,
    "losses": 0,
    "eloRating": 1000
  }'

# Get leaderboard
curl "http://localhost:5000/api/players/leaderboard?limit=5"

# Health check
curl http://localhost:5000/health
```

4. **Use GitHub Copilot to generate tests:**

```
@workspace Generate comprehensive integration tests for the Player Stats API using xUnit and WebApplicationFactory
```

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Application runs on .NET 8
- [ ] All minimal API endpoints return correct responses
- [ ] Swagger UI displays all endpoints
- [ ] EF Core successfully manages database operations
- [ ] Health check endpoint returns healthy status
- [ ] Tests pass with >80% coverage
- [ ] No .NET Framework dependencies remain

## 🎯 Validation Commands

```bash
# Build
dotnet build

# Run tests (after creating test project)
dotnet test

# Check for .NET 8
dotnet --list-sdks

# Publish for production
dotnet publish -c Release

# Run published app
cd bin/Release/net8.0/publish
dotnet PlayerStatsAPI.dll
```

## 🐛 Troubleshooting

### Issue 1: EF Core migration errors
**Solution**: Ensure connection string is correct and migrations are applied
```bash
dotnet ef migrations add InitialCreate
dotnet ef database update
```

### Issue 2: Swagger not showing
**Solution**: Verify Swagger is enabled in Program.cs
```csharp
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
```

### Issue 3: CORS errors from frontend
**Solution**: Add CORS policy before other middleware
```csharp
app.UseCors("AllowAll");
```

## 🎓 Key Takeaways

1. **.NET 8 is faster, cross-platform, and cloud-ready**
2. **Minimal APIs reduce boilerplate** compared to traditional controllers
3. **EF Core is more performant** than EF 6
4. **Native AOT compilation** provides near-instant startup times
5. **GitHub Copilot** can automate 80%+ of migration tasks

## 📚 Additional Resources

- [.NET 8 Migration Guide](https://learn.microsoft.com/en-us/dotnet/core/porting/)
- [Minimal APIs Documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis)
- [Entity Framework Core](https://learn.microsoft.com/en-us/ef/core/)
- [Native AOT Deployment](https://learn.microsoft.com/en-us/dotnet/core/deploying/native-aot)
- [GitHub Copilot for .NET](https://github.blog/changelog/2025-09-22-github-copilot-app-modernization-is-now-generally-available-for-java-and-net/)

## 🚀 Next Steps

Awesome work! You've modernized the Player Stats API. Now move on to:

**[Exercise 3: Angular Frontend Modernization →](exercise-3-angular.md)**

Or explore bonus challenges:
- Add JWT authentication
- Implement caching with Redis
- Add SignalR for real-time updates
- Deploy to Azure App Service

---

**⚡ Achievement Unlocked: .NET Modernization Master!**
