# Exercise 1: Java Tournament Service Modernization 🏆

**Duration**: 30 minutes  
**Difficulty**: ⭐⭐⭐ Intermediate  
**Prerequisites**: Java 17+, Maven 3.8+, GitHub Copilot enabled

## 🎮 The Challenge

The **Tournament Service** is the backbone of Game Arena Legends. It handles tournament creation, player registration, bracket generation, and match scheduling. Built in 2015 with Spring Boot 2.7, it's showing its age:

- 🐌 Blocking I/O operations causing slow response times during peak traffic
- 📦 Outdated dependencies with known security vulnerabilities
- 🔧 Missing observability for production debugging
- ⚠️ No support for reactive programming patterns

Your mission: **Modernize this service to handle 10x the current traffic using Spring Boot 3.2 and reactive patterns.**

## 📋 What You'll Learn

- ✅ Migrate Spring Boot 2.7 → 3.2
- ✅ Convert blocking controllers to reactive WebFlux
- ✅ Implement virtual threads (Project Loom)
- ✅ Add health checks and metrics with Actuator
- ✅ Update dependencies and fix breaking changes
- ✅ Use GitHub Copilot agents for automated migration analysis

## 🏗️ Architecture Overview

**Before (Legacy):**
```
Spring Boot 2.7.x
├── Traditional servlet-based (Tomcat)
├── Blocking JDBC with JPA
├── Synchronous REST controllers
└── Thread-per-request model
```

**After (Modernized):**
```
Spring Boot 3.2.x
├── Reactive WebFlux (Netty)
├── R2DBC for reactive database access
├── Reactive controllers with Mono/Flux
└── Virtual threads for I/O operations
```

## 🚀 Step-by-Step Guide

### Step 1: Analyze the Legacy Code (5 minutes)

1. Navigate to the legacy code:
```bash
cd legacy-code/java-tournament-service
```

2. Open `pom.xml` and observe:
   - Spring Boot version: 2.7.18
   - Java version: 11
   - Deprecated dependencies

3. Use GitHub Copilot to analyze the project:

**Open Copilot Chat** (`Ctrl+Alt+I` or `Cmd+Alt+I`) and ask:

```
@workspace Analyze this Spring Boot project and list all deprecated dependencies and APIs that need updating for Spring Boot 3.2
```

4. Review the output and note the key issues:
   - [ ] Spring Boot version outdated
   - [ ] Java 17+ required
   - [ ] Javax → Jakarta namespace migration needed
   - [ ] Blocking I/O in controllers

### Step 2: Update Dependencies with Copilot (5 minutes)

1. Open `pom.xml` in VS Code

2. Use Copilot Chat:
```
Update this pom.xml to Spring Boot 3.2.x, Java 17, and add Spring WebFlux dependencies. Also include spring-boot-starter-actuator and micrometer-registry-prometheus.
```

3. **Expected Changes:**

```xml
<parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.2.0</version>
</parent>

<properties>
    <java.version>17</java.version>
</properties>

<dependencies>
    <!-- WebFlux for reactive -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-webflux</artifactId>
    </dependency>
    
    <!-- R2DBC for reactive database -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-r2dbc</artifactId>
    </dependency>
    
    <!-- Actuator for health checks -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
    
    <!-- Prometheus metrics -->
    <dependency>
        <groupId>io.micrometer</groupId>
        <artifactId>micrometer-registry-prometheus</artifactId>
    </dependency>
</dependencies>
```

4. Run Maven update:
```bash
mvn clean install
```

### Step 3: Migrate Javax to Jakarta (5 minutes)

Spring Boot 3.x uses Jakarta EE instead of Java EE.

1. **Use Copilot for bulk migration:**

Select all Java files (`Ctrl+Shift+F` → search for `javax.`)

In Copilot Chat:
```
@workspace Replace all javax.* imports with jakarta.* equivalents across the entire project
```

2. **Key replacements:**
   - `javax.persistence.*` → `jakarta.persistence.*`
   - `javax.validation.*` → `jakarta.validation.*`
   - `javax.servlet.*` → `jakarta.servlet.*`

3. Verify:
```bash
mvn compile
```

### Step 4: Convert Controllers to Reactive (10 minutes)

This is the core modernization step!

#### Example: TournamentController.java

**Legacy (Blocking):**
```java
@RestController
@RequestMapping("/api/tournaments")
public class TournamentController {
    
    @Autowired
    private TournamentService tournamentService;
    
    @GetMapping("/{id}")
    public ResponseEntity<Tournament> getTournament(@PathVariable Long id) {
        Tournament tournament = tournamentService.findById(id);
        return ResponseEntity.ok(tournament);
    }
    
    @GetMapping
    public ResponseEntity<List<Tournament>> getAllTournaments() {
        List<Tournament> tournaments = tournamentService.findAll();
        return ResponseEntity.ok(tournaments);
    }
    
    @PostMapping
    public ResponseEntity<Tournament> createTournament(@RequestBody Tournament tournament) {
        Tournament created = tournamentService.save(tournament);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }
}
```

**Use GitHub Copilot to Modernize:**

1. Open `TournamentController.java`
2. Select the entire controller class
3. Press `Ctrl+I` (inline chat) and ask:

```
Convert this controller to use Spring WebFlux with Mono and Flux. Make all methods reactive and non-blocking.
```

**Expected Modernized Code:**
```java
@RestController
@RequestMapping("/api/tournaments")
public class TournamentController {
    
    private final TournamentService tournamentService;
    
    public TournamentController(TournamentService tournamentService) {
        this.tournamentService = tournamentService;
    }
    
    @GetMapping("/{id}")
    public Mono<ResponseEntity<Tournament>> getTournament(@PathVariable Long id) {
        return tournamentService.findById(id)
            .map(ResponseEntity::ok)
            .defaultIfEmpty(ResponseEntity.notFound().build());
    }
    
    @GetMapping
    public Flux<Tournament> getAllTournaments() {
        return tournamentService.findAll();
    }
    
    @PostMapping
    public Mono<ResponseEntity<Tournament>> createTournament(@RequestBody Tournament tournament) {
        return tournamentService.save(tournament)
            .map(created -> ResponseEntity.status(HttpStatus.CREATED).body(created));
    }
}
```

4. **Key Changes:**
   - `List<T>` → `Flux<T>` (multiple items)
   - `T` → `Mono<T>` (single item)
   - Non-blocking operations with reactive streams

### Step 5: Modernize Repository Layer (5 minutes)

1. Open `TournamentRepository.java`

**Legacy (Blocking JPA):**
```java
@Repository
public interface TournamentRepository extends JpaRepository<Tournament, Long> {
    List<Tournament> findByStatus(String status);
}
```

2. Use Copilot to convert to R2DBC:

```
Convert this JpaRepository to ReactiveCrudRepository using R2DBC
```

**Modernized (Reactive R2DBC):**
```java
@Repository
public interface TournamentRepository extends ReactiveCrudRepository<Tournament, Long> {
    Flux<Tournament> findByStatus(String status);
}
```

3. Update entity class with R2DBC annotations:

```java
@Table("tournaments")
public class Tournament {
    @Id
    private Long id;
    
    private String name;
    private String game;
    private String status;
    private LocalDateTime startDate;
    
    // Getters and setters
}
```

### Step 6: Add Health Checks and Metrics (3 minutes)

1. Create `application.yml`:

```yaml
spring:
  application:
    name: tournament-service
  r2dbc:
    url: r2dbc:postgresql://localhost:5432/game_arena
    username: postgres
    password: postgres

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always
  metrics:
    export:
      prometheus:
        enabled: true

server:
  port: 8080
```

2. Test the endpoints:
```bash
mvn spring-boot:run

# In another terminal
curl http://localhost:8080/actuator/health
curl http://localhost:8080/actuator/metrics
```

### Step 7: Enable Virtual Threads (2 minutes)

Add virtual threads support for I/O operations:

```java
@Configuration
public class VirtualThreadConfig {
    
    @Bean
    public TaskExecutor taskExecutor() {
        return new SimpleAsyncTaskExecutor(task -> 
            Thread.ofVirtual().start(task)
        );
    }
}
```

### Step 8: Test the Modernized Service (5 minutes)

1. **Run the application:**
```bash
mvn spring-boot:run
```

2. **Test reactive endpoints:**
```bash
# Create a tournament
curl -X POST http://localhost:8080/api/tournaments \
  -H "Content-Type: application/json" \
  -d '{"name": "Spring Championship 2024", "game": "League of Legends", "status": "UPCOMING"}'

# Get all tournaments (reactive stream)
curl http://localhost:8080/api/tournaments

# Get single tournament
curl http://localhost:8080/api/tournaments/1
```

3. **Check health and metrics:**
```bash
curl http://localhost:8080/actuator/health
curl http://localhost:8080/actuator/metrics/jvm.threads.virtual
```

4. **Generate unit tests with Copilot:**

Open Copilot Chat:
```
@workspace Generate comprehensive unit tests for TournamentController using WebTestClient and Mockito
```

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Application starts successfully on port 8080
- [ ] All endpoints return data in reactive manner (Mono/Flux)
- [ ] Health check returns UP status
- [ ] Metrics endpoint shows Prometheus format data
- [ ] Unit tests pass with >80% coverage
- [ ] No blocking I/O in controllers or services
- [ ] Virtual threads are enabled and visible in metrics

## 🎯 Validation Commands

```bash
# Build and test
mvn clean test

# Check for blocking code (should return no results)
grep -r "block()" src/main/java/

# Verify reactive patterns
grep -r "Mono\|Flux" src/main/java/

# Start application
mvn spring-boot:run
```

## 🐛 Troubleshooting

### Issue 1: Compilation errors after Spring Boot 3 upgrade
**Solution**: Ensure all javax.* imports are replaced with jakarta.*
```bash
find src -name "*.java" -exec sed -i 's/javax\./jakarta./g' {} +
```

### Issue 2: R2DBC connection failures
**Solution**: Check R2DBC URL format and ensure PostgreSQL is running
```bash
docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:15
```

### Issue 3: Tests failing with WebTestClient
**Solution**: Add `@WebFluxTest` annotation and mock repositories
```java
@WebFluxTest(TournamentController.class)
class TournamentControllerTest {
    @MockBean
    private TournamentService service;
    
    @Autowired
    private WebTestClient webClient;
}
```

## 🎓 Key Takeaways

1. **Spring Boot 3.x requires Java 17+** and Jakarta EE namespace
2. **Reactive programming** (WebFlux) provides better scalability for I/O-bound operations
3. **Virtual threads** simplify concurrent programming without reactive complexity
4. **GitHub Copilot** can automate 70-80% of migration tasks
5. **Actuator + Prometheus** provide production-ready observability

## 📚 Additional Resources

- [Spring Boot 3.0 Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide)
- [Spring WebFlux Documentation](https://docs.spring.io/spring-framework/reference/web/webflux.html)
- [Project Loom (Virtual Threads)](https://openjdk.org/projects/loom/)
- [GitHub Copilot for Java](https://docs.github.com/en/copilot/tutorials/modernize-java-applications)

## 🚀 Next Steps

Congratulations! You've modernized the Tournament Service. Now move on to:

**[Exercise 2: .NET API Modernization →](exercise-2-dotnet.md)**

Or explore bonus challenges:
- Add GraphQL API layer
- Implement WebSocket for real-time tournament updates
- Add distributed tracing with Zipkin
- Deploy to Kubernetes

---

**🏆 Achievement Unlocked: Java Modernization Expert!**
