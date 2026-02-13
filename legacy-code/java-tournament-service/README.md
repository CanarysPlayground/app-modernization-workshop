# Game Arena Tournament Service (Legacy)

## 🚨 LEGACY CODE - REQUIRES MODERNIZATION

This is the **legacy version** of the Tournament Service built with:
- ❌ Spring Boot 2.7.18 (outdated)
- ❌ Java 11 (needs upgrade to 17+)
- ❌ Blocking I/O (servlet-based)
- ❌ JPA with H2 (blocking database access)
- ❌ Javax namespace (needs jakarta migration)

## Known Issues

1. **Performance Bottleneck**: Blocking I/O limits concurrent request handling
2. **Scalability**: Thread-per-request model doesn't scale well
3. **Security**: Multiple deprecated dependencies with CVEs
4. **Observability**: No health checks or metrics
5. **Modern Features**: Missing reactive patterns, virtual threads

## Quick Start

```bash
# Build
mvn clean install

# Run
mvn spring-boot:run

# Test
curl http://localhost:8080/api/tournaments
```

## Your Mission

Follow [Exercise 1](../../docs/exercise-1-java.md) to modernize this service to Spring Boot 3.2 with reactive patterns!

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/tournaments` | Get all tournaments |
| GET | `/api/tournaments/{id}` | Get tournament by ID |
| POST | `/api/tournaments` | Create tournament |
| PUT | `/api/tournaments/{id}` | Update tournament |
| DELETE | `/api/tournaments/{id}` | Delete tournament |
| GET | `/api/tournaments/status/{status}` | Get by status |
| GET | `/api/tournaments/game/{game}` | Get by game |

## Sample Request

```bash
curl -X POST http://localhost:8080/api/tournaments \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Spring Championship 2024",
    "game": "League of Legends",
    "status": "UPCOMING",
    "startDate": "2024-06-01T10:00:00",
    "maxParticipants": 128,
    "prizePool": 50000.0
  }'
```

---

**Ready to modernize? Head to [Exercise 1](../../docs/exercise-1-java.md)! 🚀**
