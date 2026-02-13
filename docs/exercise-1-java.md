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

### Step 1: Use Extension to Analyze Legacy Code (5 minutes)

1. **Open the project in VS Code:**
```bash
cd legacy-code/java-tournament-service
code .
```

2. **Use GitHub Copilot App Modernization Extension for Assessment:**

   **Method A: Right-Click Assessment (Recommended)**
   - In VS Code Explorer, right-click on `pom.xml`
   - Select **"Copilot: Analyze for Java Upgrade"**
   - Wait 30-60 seconds for the automated analysis
   - Review the **Assessment Report** that appears

   **Method B: Chat Command**
   - Open Copilot Chat (`Ctrl+Alt+I` or `Cmd+Alt+I`)
   - Run: `@workspace /agent AppModernization-Java analyze this Spring Boot project`

3. **Review the Automated Assessment Report:**

   The extension will provide:
   ```
   📊 ASSESSMENT REPORT
   ==================
   Current Version: Spring Boot 2.7.18 on Java 11
   Target Version: Spring Boot 3.2.x on Java 17+
   
   ⚠️ Issues Found: 15
   
   CRITICAL:
   - Spring Boot version outdated (EOL)
   - Java 11 not supported for Spring Boot 3.x
   - javax.* packages must migrate to jakarta.*
   
   WARNINGS:
   - Blocking I/O patterns detected
   - Deprecated Spring Security configurations
   - H2 database needs reactive driver
   
   📈 Migration Complexity: MEDIUM
   ⏱️ Estimated Time: 2-3 hours
   
   ✅ Recommended Path:
   1. Update Java 11 → 17
   2. Update Spring Boot 2.7 → 3.2
   3. Migrate javax → jakarta
   4. Convert to reactive endpoints (optional)
   ```

4. **The extension will highlight issues in your code:**
   - Yellow underlines on deprecated code
   - Red underlines on breaking changes
   - Blue suggestions for improvements

### Step 2: Use Extension's Automated Upgrade (5 minutes)

**The extension can automatically update your pom.xml!**

1. **Open `pom.xml`** - You should see:
   - 💡 Copilot lightbulb icons on outdated dependencies
   - Underlined version numbers
   
2. **Start the Automated Upgrade:**

   **Option A: Use Quick Fix (Easiest)**
   - Click on the Spring Boot version line
   - Look for the 💡 lightbulb icon
   - Click "Update to Spring Boot 3.2" from the menu
   - The extension will automatically update compatible dependencies!

   **Option B: Use Extension Command**
   - Right-click on `pom.xml`
   - Select **"Copilot: Upgrade Java Project"**
   - Choose "Spring Boot 3.2" from the dropdown
   - Confirm the changes

3. **Review the Automated Changes:**

   The extension will show you a diff view with all proposed changes:

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

### Step 3: Use Extension for Automated Javax→Jakarta Migration (5 minutes)

**The extension handles this automatically!**

1. **Trigger the Migration:**
   - Open any Java file with `javax` imports (e.g., `Tournament.java`)
   - Look for yellow warnings on `import javax.*` lines
   - Click the 💡 lightbulb icon
   - Select **"Migrate to Jakarta EE"**
   
2. **Or use the batch migration:**
   - Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
   - Type: "Copilot: Migrate javax to jakarta"
   - Press Enter
   - The extension will scan all files and show a preview
   - Click **"Apply All Changes"**

3. **Extension shows you the migration summary:**
   ```
   ✅ Migrated Imports:
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

### Step 4: Use Extension to Convert Controllers to Reactive (10 minutes)

**Let the extension guide your reactive conversion!**

1. **Open `TournamentController.java`**

2. **Use the Extension's Reactive Conversion:**
   - Right-click anywhere in the controller class
   - Select **"Copilot: Convert to Reactive WebFlux"**
   - The extension analyzes your controller and generates reactive code

3. **Review the Transformation Plan:**
   
   The extension shows you what will change:
   ```
   📋 REACTIVE CONVERSION PLAN
   
   Will convert 7 endpoints:
   ✓ GET /api/tournaments → Flux<Tournament>
   ✓ GET /api/tournaments/{id} → Mono<Tournament>
   ✓ POST /api/tournaments → Mono<Tournament>
   ✓ PUT /api/tournaments/{id} → Mono<Tournament>
   ✓ DELETE /api/tournaments/{id} → Mono<Void>
   
   Dependencies needed:
   ✓ spring-boot-starter-webflux (already added)
   ✓ spring-boot-starter-data-r2dbc (already added)
   
   Click "Preview Changes" to see the code transformation
   ```

4. **Click "Preview Changes" to see side-by-side comparison:**

#### Extension-Generated Code:

**BEFORE (Blocking - shown by extension):**
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

5. **Click "Apply Changes"** - the extension automatically transforms your code:

**AFTER (Reactive - generated by extension):**
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

6. **Review the Extension's Summary:**
   ```
   ✅ CONVERSION COMPLETE
   
   Transformed:
   - 7 endpoints converted to reactive
   - Constructor injection applied
   - Proper error handling added
   - Flux/Mono types applied correctly
   
   Performance Impact:
   + 3x throughput improvement
   + Non-blocking I/O
   + Better resource utilization
   ```

7. **Key Changes Made by Extension:**
   - `List<T>` → `Flux<T>` (streaming multiple items)
   - `T` → `Mono<T>` (single async result)
   - Added proper error handling with `.defaultIfEmpty()`
   - Constructor injection instead of `@Autowired`

### Step 5: Use Extension for Repository Layer Modernization (5 minutes)

**Let the extension handle R2DBC migration!**

1. **Open `TournamentRepository.java`**

2. **Use the Extension's Data Layer Converter:**
   - Right-click on the repository interface
   - Select **"Copilot: Convert to Reactive Data Access"**
   - Extension detects JPA and suggests R2DBC conversion

3. **Review the Conversion Preview:**

   **BEFORE (Blocking JPA):**
   ```java
   @Repository
   public interface TournamentRepository extends JpaRepository<Tournament, Long> {
       List<Tournament> findByStatus(String status);
       List<Tournament> findByGame(String game);
   }
   ```

4. **Click "Preview Reactive Version"** - extension shows:

   **AFTER (Reactive R2DBC):**
   ```java
   @Repository
   public interface TournamentRepository extends ReactiveCrudRepository<Tournament, Long> {
       Flux<Tournament> findByStatus(String status);
       Flux<Tournament> findByGame(String game);
   }
   ```

5. **Click "Apply Migration"** - extension updates:
   - Repository interface extends `ReactiveCrudRepository`
   - Return types changed to `Flux<T>` / `Mono<T>`
   - Updates entity with R2DBC annotations:
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

6. **Extension shows migration confirmation:**
   ```
   ✅ Repository Migration Complete
   
   Changes:
   - JpaRepository → ReactiveCrudRepository
   - JPA annotations → R2DBC annotations
   - Blocking methods → Reactive Flux/Mono
   
   Dependencies updated:
   ✓ Removed: spring-boot-starter-data-jpa
   ✓ Added: spring-boot-starter-data-r2dbc
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
