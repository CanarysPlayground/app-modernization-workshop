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

## 🚀 Getting Started

### Step 1: Clone & Setup

```bash
git clone https://github.com/CanarysPlayground/app-modernization-workshop.git
cd app-modernization-workshop
cd legacy-code/java-tournament-service
```

### Step 2: Verify Setup

```bash
java -version
mvn -version
```

Ensure you have:
- **Java 17+** installed → [Download JDK 17+](https://adoptium.net/temurin/releases/)
- **Maven 3.8+** installed → [Download Maven](https://maven.apache.org/download.cgi)
- **GitHub Copilot extensions** active in VS Code:
  - [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
  - [GitHub Copilot App Modernization - Java Upgrade](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-upgrade)

### Step 3: Build Legacy Code

```bash
mvn clean install
mvn spring-boot:run
```

Test the API in another terminal:
```bash
curl http://localhost:8080/api/tournaments
```

## 📂 Project Structure

```
java-tournament-service/
├── src/main/java/
│   └── com/gamearena/tournament/
│       ├── TournamentApplication.java
│       ├── controller/
│       │   └── TournamentController.java
│       ├── service/
│       │   └── TournamentService.java
│       ├── repository/
│       │   └── TournamentRepository.java
│       └── model/
│           └── Tournament.java
├── pom.xml                    # Maven dependencies
└── application.properties     # Configuration
```

## 🔧 Step-by-Step Guide

### Step 1: Use Extension to Analyze Legacy Code (5 minutes)

1. **Open the project in VS Code:**
```bash
cd legacy-code/java-tournament-service
code .
```

2. **Use GitHub Copilot Chat for Assessment:**

   Open Copilot Chat (`Ctrl+Alt+I` or `Cmd+Alt+I`) and ask:
   ```
   @workspace Analyze this Spring Boot project for modernization. What version is it using and what needs to be upgraded to Spring Boot 3.x?
   ```

   Or use the agent:
   ```
   @workspace /agent AppModernization-Java analyze this project
   ```

3. **Review Copilot's Assessment:**

   Copilot will analyze your project and provide:
   
   - Current Spring Boot version (2.7.18)
   - Target version recommendations (3.2.x)
   - List of deprecated dependencies
   - Required Java version (17+)
   - Breaking changes to address:
     - `javax.*` → `jakarta.*` package migration
     - Blocking I/O → Reactive patterns
     - Deprecated configurations
   - Step-by-step migration recommendations

4. **Ask follow-up questions in chat:**
   ```
   What are the breaking changes between Spring Boot 2.7 and 3.2?
   ```
   ```
   Show me how to update the pom.xml for Spring Boot 3.2
   ```

### Step 2: Update pom.xml with Copilot (5 minutes)

**Use Copilot Chat to upgrade dependencies:**

1. **Open `pom.xml` in VS Code**

2. **Ask Copilot to update it:**

   In Copilot Chat:
   ```
   @workspace Update this pom.xml to Spring Boot 3.2.0 with Java 17. Add spring-boot-starter-webflux and spring-boot-starter-data-r2dbc for reactive programming. Also add actuator and prometheus metrics.
   ```

3. **Review Copilot's suggested changes:**

   Copilot will suggest updating:

3. **Apply the changes to get:**

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

### Step 3: Migrate javax to jakarta with Copilot (5 minutes)

**Use Copilot Edits for batch migration:**

1. **Open Copilot Edits** (`Ctrl+Shift+I` or `Cmd+Shift+I`)

2. **Add all Java files to the editing session:**
   - Click "Add Files" in Copilot Edits
   - Select all `.java` files in `src/main/java`

3. **Give the migration instruction:**
   ```
   Replace all javax.persistence imports with jakarta.persistence, javax.validation with jakarta.validation, and any other javax.* imports with jakarta.* equivalents throughout all files.
   ```

4. **Review and accept the changes**

5. **Expected migration summary:
   - Tournament.java: 4 imports updated
   - TournamentController.java: 2 imports updated
   - TournamentRepository.java: 1 import updated
   
   📦 Packages Affected:
   - javax.persistence → jakarta.persistence (8 files)
   - javax.validation → jakarta.validation (3 files)
   ```

4. **Verify compilation:**
```bash
mvn compile
```

### Step 4: Convert Controllers to Reactive with Copilot (10 minutes)

**Use Copilot Inline Chat for reactive conversion:**

1. **Open `TournamentController.java`**

2. **Select the entire controller class**

3. **Press `Ctrl+I` (Windows) or `Cmd+I` (Mac) for Inline Chat**

4. **Give the instruction:**
   ```
   Convert this controller to use Spring WebFlux with Mono and Flux. Make all methods reactive and non-blocking. Use constructor injection instead of @Autowired.
   ```

5. **Review Copilot's Changes:**

**BEFORE (Blocking):**
```java
@RestController
@RequestMapping("/api/tournaments")
public class TournamentController {
    @Autowired
    private TournamentService tournamentService;
    
    @GetMapping("/{id}")
    public ResponseEntity<Tournament> getTournament(@PathVariable Long id) {
        return ResponseEntity.ok(tournamentService.findById(id));
    }
    
    @GetMapping
    public ResponseEntity<List<Tournament>> getAllTournaments() {
        return ResponseEntity.ok(tournamentService.findAll());
    }
}
```

6. **Accept Copilot's transformation:**

**AFTER (Reactive):**
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

7. **Key Changes Copilot Made:**
   - `List<T>` → `Flux<T>` (streaming multiple items)
   - `T` → `Mono<T>` (single async result)
   - Added proper error handling with `.defaultIfEmpty()`
   - Constructor injection instead of `@Autowired`

8. **Repeat for Service and Repository layers** using the same Inline Chat approach

### Step 5: Modernize Repository Layer with Copilot (5 minutes)

**Use Copilot to convert JPA to R2DBC:**

1. **Open `TournamentRepository.java`**

2. **Select the repository interface**

3. **Press `Ctrl+I` for Inline Chat and ask:**
   ```
   Convert this JpaRepository to ReactiveCrudRepository using R2DBC. Update all return types to use Flux and Mono.
   ```

4. **Review the changes:**

**BEFORE (Blocking JPA):**
```java
@Repository
public interface TournamentRepository extends JpaRepository<Tournament, Long> {
    List<Tournament> findByStatus(String status);
    List<Tournament> findByGame(String game);
}
```

5. **Accept Copilot's suggestion:**

**AFTER (Reactive R2DBC):**
```java
@Repository
public interface TournamentRepository extends ReactiveCrudRepository<Tournament, Long> {
    Flux<Tournament> findByStatus(String status);
    Flux<Tournament> findByGame(String game);
}
```

6. **Update the entity with R2DBC annotations:**

   Ask Copilot in chat:
   ```
   @workspace Update Tournament entity to use R2DBC annotations instead of JPA
   ```

   Apply the changes:
   ```java
   @Table("tournaments")
   public class Tournament {
       @Id
       private Long id;
       private String name;
       private String game;
       private String status;
       private LocalDateTime startDate;
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
