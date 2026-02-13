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

2. **Select the Right Model for Assessment:**

   Click the Copilot icon → **Model Selector** → Choose:
   - **GPT-4** for comprehensive analysis (recommended for assessment)
   - **Claude 3.5 Sonnet** for alternative perspective

3. **Use Agent Mode for Assessment:**

   Open Copilot Chat (`Ctrl+Alt+I` or `Cmd+Alt+I`) and use the specialized agent:
   ```
   @workspace /agent AppModernization-Java assess this Spring Boot application for upgrade to version 3.2
   ```

   The agent will use **predefined tasks** and **OpenRewrite** to analyze:
   - Current framework versions
   - CVE vulnerabilities in dependencies
   - Breaking changes requiring remediation
   - Azure cloud readiness
   - Recommended migration path

4. **Review Agent's Assessment Report:**

   The agent provides:
   - ✅ Current: Spring Boot 2.7.18, Java 11
   - 🎯 Target: Spring Boot 3.2.0, Java 17+
   - ⚠️ CVEs found: 3 high-severity issues
   - 📋 Required changes: javax→jakarta, reactive patterns
   - 🔧 Predefined tasks available: Spring Boot 3 upgrade, reactive migration

### Step 2: Apply Predefined Task for Spring Boot Upgrade (5 minutes)

**Use the agent with predefined task for dependency upgrade:**

1. **Open `pom.xml` in VS Code**

2. **Apply the Spring Boot 3 upgrade task using agent mode:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java apply predefined task "upgrade-spring-boot-3" to pom.xml
   ```

   Or use inline chat on pom.xml (`Ctrl+I`):
   ```
   Upgrade to Spring Boot 3.2.0 with Java 17, add reactive web (webflux) and data (r2dbc) dependencies, actuator, and prometheus metrics
   ```

3. **The agent uses OpenRewrite recipes to transform:**

   - Automatically updates parent version
   - Resolves compatible dependency versions
   - Adds required reactive dependencies
   - Removes deprecated dependencies

4. **Applied changes:**

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

### Step 3: Use Agent to Migrate javax to jakarta (5 minutes)

**Apply OpenRewrite recipe via agent:**

1. **Use agent mode for automated migration:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java apply predefined task "javax-to-jakarta" on all Java files
   ```

   The agent uses **OpenRewrite recipes** (`org.openrewrite.java.migrate.jakarta.*`) to:
   - Scan all Java files
   - Replace javax imports with jakarta equivalents
   - Update annotations and references
   - Apply transformations atomically

2. **Review the transformation summary from the agent**

3. **Verify with Build Agent:**

   ```
   @workspace /agent AppModernization-Java verify build
   ```

   The build agent:
   - Runs `mvn clean compile`
   - Reports any compilation errors
   - Suggests fixes if issues found
   - Shows successful build confirmation

### Step 4: Convert Controllers to Reactive with Agent (10 minutes)

**Use agent mode for reactive transformation:**

1. **Open `TournamentController.java`**

2. **Use the reactive migration agent:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java convert TournamentController to reactive WebFlux with Mono/Flux patterns
   ```

   Or use inline chat on the controller (`Ctrl+I`):
   ```
   Convert to reactive: use Flux for collections, Mono for single objects, constructor injection, proper error handling
   ```

3. **Switch model for code generation:**
   - Use **Claude 3.5 Sonnet** for reactive patterns (handles async well)
   - Or **GPT-4o** for balanced approach

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

7. **Key Changes Agent Applied:**
   - `List<T>` → `Flux<T>` (streaming multiple items)
   - `T` → `Mono<T>` (single async result)
   - Added proper error handling with `.defaultIfEmpty()`
   - Constructor injection instead of `@Autowired`

### Step 5: Modernize Repository with Agent (5 minutes)

**Use agent for data layer transformation:**

1. **Convert repository to reactive:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java convert TournamentRepository from JpaRepository to ReactiveCrudRepository with R2DBC
   ```

2. **The agent automatically:**
   - Changes base interface to `ReactiveCrudRepository`
   - Updates all method signatures to return `Flux`/`Mono`
   - Modifies entity annotations for R2DBC
   - Updates service layer to handle reactive types

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

3. **Entity updated automatically:**
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

### Step 6: Run CVE Check and Build Verification (3 minutes)

**Use agents for security and build validation:**

1. **Check for CVE vulnerabilities:**

   ```
   @workspace /agent AppModernization-Java check CVEs in dependencies
   ```

   Agent reports:
   - High-severity vulnerabilities found
   - Recommended version upgrades
   - Automatic remediation available

2. **Apply CVE fixes:**

   ```
   @workspace /agent AppModernization-Java remediate CVEs
   ```

3. **Verify build integrity:**

   ```
   @workspace /agent AppModernization-Java verify build and run tests
   ```

   Build agent:
   - Compiles the project
   - Runs existing tests
   - Reports test coverage
   - Confirms successful modernization

### Step 7: Add Health Checks and Metrics (3 minutes)

**Use agent to configure observability:**

1. **Generate application configuration with agent:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java add actuator configuration with prometheus metrics and health checks to application.yml
   ```

2. **Agent creates `application.yml`:**

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

3. **Test endpoints:**
```bash
mvn spring-boot:run
curl http://localhost:8080/actuator/health
curl http://localhost:8080/actuator/metrics
```

### Step 8: Enable Virtual Threads with Agent (2 minutes)

**Use agent for Java 21 virtual threads:**

1. **Generate virtual thread configuration:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java add virtual threads configuration for better concurrency
   ```

2. **Agent creates configuration:

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

### Step 9: Generate Tests with Agent (3 minutes)

**Use test generation agent:**

1. **Generate comprehensive tests:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java generate unit tests for TournamentController with WebTestClient and 80% coverage
   ```

2. **Agent generates:**
   - Test class with proper annotations (`@WebFluxTest`)
   - Mock beans configuration
   - Test methods for all endpoints
   - Reactive test patterns with `StepVerifier`

3. **Verify tests:**
   ```bash
   mvn test
   ```

### Step 10: Containerize for Azure with Agent (4 minutes)

**Use agent for Docker and Azure deployment:**

1. **Generate Dockerfile:**

   In Copilot Chat:
   ```
   @workspace /agent AppModernization-Java generate optimized Dockerfile for Azure Container Apps deployment
   ```

2. **Agent creates Dockerfile with:**
   - Multi-stage build
   - Java 17 base image
   - Optimized layers
   - Health check endpoint

3. **Test containerization:**
   ```bash
   docker build -t tournament-service:latest .
   docker run -p 8080:8080 tournament-service:latest
   ```

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Agent assessment shows Spring Boot 3.2.0 and Java 17+
- [ ] All CVEs remediated (verified by CVE agent)
- [ ] Build verification agent confirms successful compilation
- [ ] Application starts successfully on port 8080
- [ ] All endpoints return data reactively (Mono/Flux)
- [ ] Health check returns UP status with reactive components
- [ ] Test coverage >80% (verified by test agent)
- [ ] Dockerfile builds and container runs successfully
- [ ] No blocking I/O in controllers or services
- [ ] Virtual threads enabled and visible in metrics

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

1. **Agent Mode** is more powerful than ask mode - use `@workspace /agent` for structured workflows
2. **Model Selection** matters - GPT-4 for analysis, Claude 3.5 Sonnet for reactive code patterns
3. **Predefined Tasks** automate common scenarios - Spring Boot upgrade, javax→jakarta migration
4. **OpenRewrite Integration** enables precise, automated code transformations at scale
5. **Specialized Agents** handle specific tasks - build verification, CVE remediation, test generation
6. **CVE Checking** should be part of every modernization - security is built-in
7. **Reactive Programming** (WebFlux) provides better scalability for I/O-bound operations
8. **Virtual Threads** (Java 21) simplify concurrent programming
9. **Containerization** prepares apps for cloud deployment (Azure Container Apps, AKS)
10. **Agent-Driven Workflows** accelerate modernization by 70-80% vs manual migration

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
