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

### Step 1: Use Extension to Assess Legacy .NET Code (5 minutes)

1. **Open the project in VS Code:**
```bash
cd legacy-code/dotnet-stats-api
code .
```

2. **Use GitHub Copilot App Modernization for .NET Extension:**

   **Method A: Right-Click Assessment (Recommended)**
   - In VS Code Explorer, right-click on the **project folder** or `PlayerStatsAPI.csproj`
   - Select **"Copilot: Assess for .NET Modernization"**
   - Wait ~60 seconds for deep analysis
   - The **Assessment Report** will appear in a new panel

   **Method B: Chat Command**
   - Open Copilot Chat (`Ctrl+Alt+I` or `Cmd+Alt+I`)
   - Run: `@workspace /agent AppModernization-DotNet assess this .NET Framework project`

3. **Review the Comprehensive Assessment Report:**

   The extension provides a detailed analysis:
   ```
   📊 .NET MODERNIZATION ASSESSMENT
   ================================
   
   PROJECT DETAILS:
   Current: .NET Framework 4.8 (Windows-only)
   Target: .NET 8.0 (Cross-platform)
   Project Type: ASP.NET Web API
   
   ⚠️ COMPATIBILITY ANALYSIS:
   
   BLOCKERS (0):
   ✅ No blocking issues found
   
   API CHANGES REQUIRED (12):
   - System.Web → Microsoft.AspNetCore (5 files)
   - Entity Framework 6 → EF Core 8 (3 files)
   - Web API Controllers → Minimal APIs (1 file)
   - IHttpActionResult → IResult (7 methods)
   
   PACKAGE UPDATES (8):
   - EntityFramework 6.4.4 → Microsoft.EntityFrameworkCore 8.0
   - Microsoft.AspNet.WebApi 5.2.9 → [use built-in]
   - Newtonsoft.Json 12.0.3 → System.Text.Json (recommended)
   
   📈 MIGRATION STRATEGY:
   Complexity: MEDIUM
   Estimated Effort: 3-4 hours
   Recommended: Create new .NET 8 project and port code
   Reason: .NET Framework cannot upgrade in-place to .NET Core/8
   ```

4. **Extension highlights issues in your code:**
   - Files using incompatible APIs are marked
   - Hover over errors to see migration suggestions
   - Click lightbulbs for quick fixes

### Step 2: Use Extension's Guided Migration Wizard (5 minutes)

**The extension provides a step-by-step migration wizard!**

1. **Start the Migration Wizard:**
   - After assessment, click **"Start Guided Migration"** in the assessment report
   - OR: Right-click project → **"Copilot: Start .NET 8 Migration Wizard"**

2. **Follow the Wizard Steps:**

   **Step 1/5: Create Target Project**
   ```
   🎯 Create .NET 8 Project
   
   The extension will:
   ✓ Create new .NET 8 Web API project structure
   ✓ Set up modern project file (.csproj)
   ✓ Configure proper SDK version
   
   Location: ../modernized-code/dotnet-stats-api
   Template: web API (minimal)
   
   [Create Project] [Cancel]
   ```
   - Click **"Create Project"**
   - Extension generates the new structure automatically

   **Step 2/5: Migrate Models**
   ```
   📦 Migrate Data Models
   
   Models to migrate:
   ✓ Player.cs (3 changes needed)
   ✓ MatchHistory.cs (2 changes needed)
   
   Changes:
   - Update namespace declarations
   - Update EF annotations
   - Remove legacy attributes
   
   [Preview Changes] [Apply Migration]
   ```
   - Click **"Preview Changes"** to see side-by-side comparison
   - Click **"Apply Migration"** to copy and update models

   **Step 3/5: Migrate DbContext**

   **Step 4/5: Convert to Minimal APIs**
   ```
   🚀 Modernize API Endpoints
   
   The extension will convert your controllers to minimal APIs!
   
   PlayersController.cs has 7 endpoints:
   ✓ GET /api/players → Minimal API
   ✓ GET /api/players/{id} → Minimal API
   ✓ POST /api/players → Minimal API
   ✓ PUT /api/players/{id} → Minimal API
   ✓ DELETE /api/players/{id} → Minimal API
   ✓ GET /api/players/leaderboard → Minimal API
   
   Benefits:
   - 60% less boilerplate code
   - Better performance
   - Modern C# patterns
   
   [Show Preview] [Convert All]
   ```
   - Click **"Show Preview"** to see the new minimal API code
   - Click **"Convert All"** to apply changes

   **Step 5/5: Update Dependencies & Test**
   ```
   ✅ Finalize Migration
   
   Remaining tasks:
   ✓ Add NuGet packages (EF Core, Swagger)
   ✓ Update connection strings
   ✓ Generate Program.cs with minimal APIs
   ✓ Configure services and middleware
   
   [Complete Migration] [Review Summary]
   ```
   - Click **"Complete Migration"**
   - Extension finalizes all configurations

3. **Review the Migration Summary:**
   The extension shows you everything that was done:
   ```
   🎉 MIGRATION COMPLETED
   
   Files Created: 8
   Files Modified: 0
   Lines of Code: 423 (down from 687)
   
   Next Steps:
   1. Review generated code in Program.cs
   2. Test endpoints with: dotnet run
   3. Open Swagger UI at: http://localhost:5000/swagger
   ```

### Step 3: Use Extension to Migrate Data Models (5 minutes)

**Let the extension handle model modernization!**

1. **Navigate to legacy code:**
   ```bash
   cd ../legacy-code/dotnet-stats-api/Models
   ```

2. **Open `Player.cs` in VS Code**

3. **Use the Extension's Model Migrator:**
   - Right-click on the `Player.cs` file in Explorer
   - Select **"Migrate to .NET 8"**
   - Extension analyzes the model and shows migration plan

4. **Review the Migration Preview:**

   The extension shows a side-by-side comparison:
   
   **BEFORE (.NET Framework 4.8):**
   ```csharp
   using System.ComponentModel.DataAnnotations;
   using System.Data.Entity;
   
   public class Player
   {
       [Key]
       public int Id { get; set; }
       public string Username { get; set; }
       // Old nullable reference approach
   }
   ```
   
   **AFTER (.NET 8 - Extension Preview):**
   ```csharp
   using System.ComponentModel.DataAnnotations;
   using System.ComponentModel.DataAnnotations.Schema;
   
   namespace PlayerStatsAPI.Models;  // File-scoped namespace
   
   [Table("Players")]
   public class Player
   {
       [Key]
       public int Id { get; set; }
   
       [Required]
       [MaxLength(100)]
       public string Username { get; set; } = string.Empty;  // Nullable reference types
   }
   ```

5. **Click "Apply Migration"** - extension creates modernized models:

**Complete Modern Player.cs:**
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

6. **Extension shows migration summary:**
   ```
   ✅ Model Migration Complete
   
   Player.cs changes:
   - Added file-scoped namespace
   - Applied nullable reference types
   - Updated validation attributes
   - Modernized collection initialization
   - Added computed properties (WinRate)
   
   MatchHistory.cs changes:
   - Updated foreign key relationships
   - Added proper navigation properties
   - Applied modern C# 12 patterns
   ```

7. **Repeat for `MatchHistory.cs`** - extension handles it automatically!

### Step 4: Use Extension to Migrate DbContext (5 minutes)

**Let the extension convert Entity Framework 6 to EF Core!**

1. **Open `StatsDbContext.cs` in the legacy code**

2. **Use the Extension's DbContext Migrator:**
   - Right-click on `StatsDbContext.cs`
   - Select **"Migrate DbContext to EF Core"**
   - Extension analyzes your context and relationships

3. **Review the Conversion Plan:**

   Extension shows what will change:
   ```
   📋 DBCONTEXT MIGRATION PLAN
   
   Will convert:
   ✓ DbContext base class (EF6 → EF Core)
   ✓ DbSet properties (use Set<T>() pattern)
   ✓ OnModelCreating (update fluent API)
   ✓ Configuration (move to Dependency Injection)
   
   Detected relationships:
   - Player → MatchHistories (1:Many)
   
   [Preview Migration] [Apply Changes]
   ```

4. **Click "Preview Migration"** to see side-by-side:

   **BEFORE (.NET Framework EF6):**
   ```csharp
   public class StatsDbContext : DbContext
   {
       public StatsDbContext() : base("name=StatsConnection") { }
       
       public DbSet<Player> Players { get; set; }
       public DbSet<MatchHistory> MatchHistories { get; set; }
   }
   ```

5. **Click "Apply Changes"** - extension generates:

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

6. **Extension completes the migration:**
   ```
   ✅ DbContext Migration Complete
   
   Modernized:
   - Constructor now uses dependency injection
   - DbSet properties use Set<T>() pattern
   - Fluent API updated to EF Core syntax
   - Seed data added with strongly-typed configuration
   
   Next step: Configure in Program.cs
   ```

### Step 5: Use Extension to Convert to Minimal APIs (10 minutes)

**This is the biggest modernization - let the extension handle it!**

1. **Open the legacy `PlayersController.cs`**

2. **Use the Extension's Minimal API Converter:**
   - Right-click on `PlayersController.cs`
   - Select **"Convert to Minimal APIs"**
   - Extension analyzes all controller endpoints

3. **Review the Conversion Plan:**

   Extension shows what will be created:
   ```
   🚀 MINIMAL API CONVERSION PLAN
   
   PlayersController.cs → Program.cs endpoints
   
   Will convert 7 endpoints:
   ✓ GET /api/players → app.MapGet()
   ✓ GET /api/players/{id} → app.MapGet()
   ✓ POST /api/players → app.MapPost()
   ✓ PUT /api/players/{id} → app.MapPut()
   ✓ DELETE /api/players/{id} → app.MapDelete()
   ✓ GET /api/players/leaderboard → app.MapGet()
   ✓ GET /api/players/{id}/stats → app.MapGet()
   
   Benefits:
   - 60% less code
   - Better performance
   - Modern C# 12 patterns
   - Automatic OpenAPI/Swagger
   
   [Preview Minimal APIs] [Convert All]
   ```

4. **Click "Preview Minimal APIs"** - extension shows the generated code:

5. **Click "Convert All"** - extension generates:

**Modern Program.cs with Minimal APIs (generated by extension):**

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

6. **Extension shows completion summary:**
   ```
   ✅ MINIMAL API CONVERSION COMPLETE
   
   Success! Generated modern Program.cs with:
   - 7 minimal API endpoints (GetAllPlayers, GetById, Create, Update, Delete, Leaderboard, Stats)
   - OpenAPI/Swagger configuration
   - Dependency injection setup
   - Health check endpoint
   
   Code reduction:
   - Before: 687 lines (Controllers + Startup)
   - After: 423 lines (Program.cs only)
   - Savings: 38% less code!
   
   Performance improvements:
   + Faster startup time
   + Reduced memory footprint
   + Native AOT compatible
   ```

### Step 6: Test the Modernized API (3 minutes)

1. **Run the application:**

```bash
cd ../modernized-code/dotnet-stats-api
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
