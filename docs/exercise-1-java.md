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

- ✅ Migrate Spring Boot 2.7 → 3.2 with ONE comprehensive Copilot prompt
- ✅ Understand Copilot's intelligent cascading transformations
- ✅ Convert blocking I/O to reactive WebFlux (Mono/Flux)
- ✅ Check and fix security vulnerabilities (CVEs)
- ✅ Generate automated reactive tests with WebTestClient
- ✅ Add production observability (Actuator + Prometheus)
- ✅ Containerize with Docker multi-stage builds
- ✅ Validate complete modernization end-to-end

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

### Step 1: Use Copilot for Assessment (4 minutes)

1. **Open the project in VS Code:**
```bash
cd legacy-code/java-tournament-service
code .
```

2. **Select the Right Model for Assessment:**

   Click the Copilot icon → **Model Selector** → Choose:
   - **GPT-4** for comprehensive analysis (recommended for assessment)
   - **Claude 3.5 Sonnet** for alternative perspective

3. **Use Copilot Chat for Assessment:**

   Open Copilot Chat (`Ctrl+Alt+I` or `Cmd+Alt+I`) and ask:
   ```
   @workspace Analyze this Spring Boot project. What version is it using? What needs to be upgraded for Spring Boot 3.2? Identify deprecated dependencies and breaking changes.
   ```

   The analysis will cover:
   - Current framework versions
   - Deprecated dependencies
   - Breaking changes (javax→jakarta)
   - Reactive patterns recommendations
   - Migration steps

4. **Review Copilot's Assessment:**

   Copilot provides:
   - ✅ Current: Spring Boot 2.7.18, Java 11
   - 🎯 Target: Spring Boot 3.2.0, Java 17+
   - 📋 Required changes: javax→jakarta, reactive patterns
   - 🔧 Step-by-step migration recommendations

### Step 2: Upgrade Spring Boot with Copilot (4 minutes)

**Use Copilot to upgrade dependencies:**

1. **Open `pom.xml` in VS Code**

2. **Use Inline Chat to upgrade:**

   Select the `<parent>` section, press `Ctrl+I` (or `Cmd+I`) and ask:
   ```
   Upgrade to Spring Boot 3.2.0 with Java 17, add reactive web (webflux) and data (r2dbc) dependencies, actuator, and prometheus metrics
   ```

3. **Copilot will update your pom.xml:**

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

### Step 3: Verify Complete Auto-Migration (3 minutes)

**🤯 Copilot's Intelligence: Step 2 auto-completed EVERYTHING!**

When you asked for "Spring Boot 3.2 with reactive web and data", Copilot understood the full modernization scope and automatically:
- ✅ Migrated `javax.*` → `jakarta.*` (Spring Boot 3 requirement)
- ✅ Converted controllers to reactive (`Flux`/`Mono`)
- ✅ Converted services to reactive patterns
- ✅ Converted repositories to `ReactiveCrudRepository`
- ✅ Added error handling (`defaultIfEmpty()`, `switchIfEmpty()`, `onErrorResume()`)
- ✅ Applied constructor injection
- ✅ Generated production-ready reactive code

**Verify the comprehensive auto-migration:**

1. **Check Controller Reactive Patterns** - Open `TournamentController.java`:

   ```java
   // ✅ Flux for collections (0..N items)
   public Flux<Tournament> getAllTournaments()
   
   // ✅ Mono for single objects (0..1 item)
   public Mono<ResponseEntity<Tournament>> getTournamentById(Long id)
   
   // ✅ Mono<Void> for delete operations
   public Mono<ResponseEntity<Void>> deleteTournament(Long id)
   
   // ✅ Constructor injection
   private final TournamentService tournamentService;
   ```

2. **Check Service Layer** - Open `TournamentService.java`:

   ```java
   // All methods return Mono or Flux
   public Mono<Tournament> findById(Long id)
   public Flux<Tournament> findAll()
   public Mono<Tournament> save(Tournament tournament)
   ```

3. **Check Repository Layer** - Open `TournamentRepository.java`:

   ```java
   // Converted from JpaRepository to ReactiveCrudRepository
   public interface TournamentRepository extends ReactiveCrudRepository<Tournament, Long> {
       Flux<Tournament> findByStatus(TournamentStatus status);
       Flux<Tournament> findByGame(String game);
   }
   ```

4. **Check Entity Annotations** - Open `Tournament.java`:

   ```java
   @Table("tournaments")  // R2DBC annotation (not @Entity)
   public class Tournament {
       @Id
       private Long id;
   }
   ```

5. **Verify compilation:**
   ```bash
   mvn clean compile
   ```

💡 **Pro Tip**: Modern LLMs understand complete modernization workflows. One comprehensive prompt can trigger cascading intelligent transformations!

### Step 4: Check Security Vulnerabilities (3 minutes)

**Use Copilot to identify and fix CVEs in dependencies:**

1. **Ask Copilot Chat to check for vulnerabilities:**

   ```
   @workspace Analyze pom.xml for known CVE vulnerabilities in dependencies. List any security issues and suggest fixes.
   ```

2. **Review Copilot's CVE report** (example output):

   ```
   Security Analysis:
   ⚠️ Found potential vulnerabilities:
   
   1. spring-boot-starter-web 2.7.18
      - CVE-2023-XXXXX (High severity)
      - Fix: Upgrade to 3.2.0 → ✅ Already done!
   
   2. h2 database 1.4.200
      - CVE-2022-XXXXX (Medium severity)
      - Fix: Upgrade to 2.2.224+
   ```

3. **Apply fixes if needed:**

   If Copilot finds outdated dependencies:
   ```bash
   # Update vulnerable dependencies
   mvn versions:use-latest-releases
   mvn clean install
   ```

4. **Verify no critical vulnerabilities:**
   ```bash
   mvn dependency:tree
   ```

💡 **Pro Tip**: Always check CVEs during modernization - upgrading frameworks often resolves security issues automatically!

### Step 5: Generate Reactive Tests (4 minutes)

**Use Copilot to generate WebFlux test cases:**

1. **Create test file** - In `src/test/java/.../controller/`:

   Right-click `TournamentController.java` → "Generate Tests"

2. **Or use Copilot Chat:**

   ```
   @workspace Generate WebFluxTest for TournamentController with WebTestClient. Include tests for all endpoints: GET all, GET by ID (200 and 404), POST create, PUT update, DELETE. Use MockBean for service.
   ```

3. **Copilot generates comprehensive tests:**

   ```java
   @WebFluxTest(TournamentController.class)
   class TournamentControllerTest {
       
       @Autowired
       private WebTestClient webClient;
       
       @MockBean
       private TournamentService service;
       
       @Test
       void getAllTournaments_shouldReturnFlux() {
           // Given
           Tournament t1 = new Tournament(1L, "Test", "LoL", TournamentStatus.UPCOMING);
           when(service.findAll()).thenReturn(Flux.just(t1));
           
           // When/Then
           webClient.get()
               .uri("/api/tournaments")
               .exchange()
               .expectStatus().isOk()
               .expectBodyList(Tournament.class)
               .hasSize(1);
       }
       
       @Test
       void getTournamentById_whenExists_shouldReturn200() {
           // Test implementation
       }
       
       @Test
       void getTournamentById_whenNotExists_shouldReturn404() {
           // Test 404 scenario
       }
   }
   ```

4. **Run the tests:**
   ```bash
   mvn test
   ```

5. **Verify all tests pass:**
   - ✅ GET endpoints return correct data
   - ✅ POST creates resources (201 Created)
   - ✅ PUT updates existing resources
   - ✅ DELETE removes resources (204 No Content)
   - ✅ 404 handling works correctly

💡 **Pro Tip**: WebFluxTest uses WebTestClient for testing reactive endpoints without starting a full server!

### Step 6: Add Health Checks and Metrics (3 minutes)

**Use Copilot to generate configuration:**

1. **Create or open `application.yml`**

2. **Use Inline Chat** (`Ctrl+I`):

   ```
   Generate Spring Boot actuator configuration with prometheus metrics, health checks showing all details, and expose health, metrics, and prometheus endpoints
   ```

3. **Copilot creates configuration:**

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

### Step 7: Run and Test the Service (4 minutes)

1. **Run the application:**
```bash
mvn spring-boot:run
```

2. **Test reactive endpoints:**
```bash
curl -X POST http://localhost:8080/api/tournaments \
  -H "Content-Type: application/json" \
  -d '{"name": "Spring Championship 2024", "game": "League of Legends", "status": "UPCOMING"}'

curl http://localhost:8080/api/tournaments
curl http://localhost:8080/api/tournaments/1
```

3. **Verify reactive streaming behavior:**

   Test that endpoints return immediately (non-blocking):
   ```bash
   # Should stream results as they arrive
   curl -N http://localhost:8080/api/tournaments
   
   # Test error handling (non-existent ID)
   curl -v http://localhost:8080/api/tournaments/99999
   # Should return 404 Not Found gracefully
   ```

4. **Validate health checks and metrics:**
```bash
# Health check should show reactive components
curl http://localhost:8080/actuator/health | jq

# Check application metrics
curl http://localhost:8080/actuator/metrics

# Verify Prometheus metrics endpoint
curl http://localhost:8080/actuator/prometheus | grep http_server_requests
```

5. **Performance comparison (optional):**

   Use Copilot Chat to understand the difference:
   ```
   @workspace Explain how the reactive WebFlux approach improves performance compared to the blocking servlet model. What metrics should I monitor?
   ```

6. **Verify no blocking code:**
   ```bash
   # Should return no results in reactive endpoints
   grep -r ".block()" src/main/java/
   ```

### Step 8: Containerize (Bonus - 5 minutes)

**Optional: Create Docker container for deployment**

1. **Ask Copilot to generate Dockerfile:**

   ```
   Create a multi-stage Dockerfile for Spring Boot 3.2 application. Use Maven for build stage and lightweight JRE 17 for runtime.
   ```

2. **Copilot generates optimized Dockerfile:**

   ```dockerfile
   # Build stage
   FROM maven:3.9-eclipse-temurin-17 AS build
   WORKDIR /app
   COPY pom.xml .
   COPY src ./src
   RUN mvn clean package -DskipTests
   
   # Runtime stage
   FROM eclipse-temurin:17-jre-alpine
   WORKDIR /app
   COPY --from=build /app/target/*.jar app.jar
   EXPOSE 8080
   ENTRYPOINT ["java", "-jar", "app.jar"]
   ```

3. **Build and run the container:**

   ```bash
   docker build -t tournament-service:latest .
   docker run -p 8080:8080 tournament-service:latest
   ```

4. **Test containerized app:**
   ```bash
   curl http://localhost:8080/actuator/health
   ```

5. **Generate docker-compose.yml with database:**

   Ask Copilot:
   ```
   Create docker-compose.yml with tournament-service and PostgreSQL database for R2DBC
   ```

💡 **Pro Tip**: Multi-stage builds reduce image size by 70%+ compared to including build tools in runtime!

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Application starts successfully on port 8080
- [ ] All endpoints return data reactively (Mono/Flux)
- [ ] No blocking I/O in controllers or services (grep check passes)
- [ ] All generated tests pass (`mvn test`)
- [ ] No critical CVE vulnerabilities in dependencies
- [ ] Health check returns UP status with reactive components
- [ ] Metrics endpoint shows Prometheus format data
- [ ] Build completes successfully with `mvn clean install`
- [ ] (Bonus) Docker container builds and runs successfully

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

1. **Copilot's Cascading Intelligence** - ONE comprehensive prompt can trigger 15+ minutes of auto-transformations
2. **Understanding Context Matters** - "Reactive web + data" tells Copilot to convert entire stack (controllers/services/repos)
3. **Model Selection** - GPT-4 for analysis, Claude 3.5 Sonnet for reactive patterns, GPT-4o for balanced approach
4. **@workspace Context** - Analyzes entire project structure before suggesting changes
5. **Verification Over Creation** - Modern workflows: verify Copilot's work > manual coding
6. **Security-First Modernization** - Always check CVEs when upgrading dependencies
7. **Test Generation** - WebTestClient for reactive endpoints, Copilot can generate comprehensive test suites
8. **Spring Boot 3.x** - Requires Java 17+ and Jakarta EE namespace (Copilot handles automatically)
9. **Reactive Patterns** - Flux (0..N), Mono (0..1), Mono<Void> (no return), proper error handling
10. **Production Readiness** - Actuator + Prometheus + Docker = deployment-ready application
11. **Modernization Acceleration** - Copilot reduces migration time by 80%+ vs manual approach

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
