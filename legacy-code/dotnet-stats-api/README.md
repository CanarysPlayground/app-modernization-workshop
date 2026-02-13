# Player Stats API (Legacy)

## 🚨 LEGACY CODE - REQUIRES MODERNIZATION

This is the **legacy version** of the Player Stats API built with:
- ❌ .NET Framework 4.8 (outdated, Windows-only)
- ❌ ASP.NET Web API 2 (old framework)
- ❌ Entity Framework 6 (blocking I/O)
- ❌ IIS hosting (not cloud-ready)

## Known Issues

1. **Platform Lock-in**: Runs only on Windows with IIS
2. **Performance**: Blocking database operations
3. **Cloud Deployment**: Cannot containerize easily
4. **API Verbosity**: Traditional controllers have too much boilerplate
5. **Legacy Dependencies**: Outdated packages with security issues

## Quick Start

**Note**: This requires Windows and .NET Framework 4.8 SDK

```bash
# Restore packages
nuget restore

# Build
msbuild PlayerStatsAPI.csproj

# Run (requires IIS Express or full IIS)
```

## Your Mission

Follow [Exercise 2](../../docs/exercise-2-dotnet.md) to modernize this API to .NET 8 with minimal APIs!

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/players` | Get all players |
| GET | `/api/players/{id}` | Get player by ID |
| POST | `/api/players` | Create player |
| PUT | `/api/players/{id}` | Update player |
| DELETE | `/api/players/{id}` | Delete player |
| GET | `/api/players/leaderboard?limit=10` | Get top players |

## Sample Request

```bash
# Note: This won't work until you set up IIS
curl -X POST http://localhost/api/players \
  -H "Content-Type: application/json" \
  -d '{
    "username": "ProGamer123",
    "email": "pro@gamearena.com",
    "totalMatches": 150,
    "wins": 95,
    "losses": 55,
    "eloRating": 1850
  }'
```

---

**Ready to modernize to .NET 8? Head to [Exercise 2](../../docs/exercise-2-dotnet.md)! ⚡**
