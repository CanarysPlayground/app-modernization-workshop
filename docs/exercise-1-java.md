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

### Step 3: Verify Auto-Migration (2 minutes)

**⚡ Copilot Intelligence: In Step 2, when you asked to upgrade to Spring Boot 3.2, Copilot automatically handled the javax→jakarta migration because it understands Spring Boot 3 requires Jakarta EE!**

**Verify what Copilot already completed:**

1. **Check the migration summary from Step 2**

   Look for Copilot's output showing:
   - ✅ All `javax.*` → `jakarta.*` packages migrated
   - ✅ WebFlux replaced `spring-boot-starter-web`
   - ✅ R2DBC replaced `spring-boot-starter-data-jpa`
   - ✅ Reactor types added to endpoints

2. **Spot-check key files:**

   Open `TournamentController.java` and verify:
   ```java
   // BEFORE: javax imports
   import javax.persistence.Entity;
   
   // AFTER: jakarta imports (auto-migrated)
   import jakarta.persistence.Entity;
   ```

3. **Verify reactive dependencies in pom.xml:**

   Copilot should have added:
   - `spring-boot-starter-webflux` (reactive web)
   - `spring-boot-starter-data-r2dbc` (reactive data)
   - `spring-boot-starter-actuator` (metrics)
   - `micrometer-registry-prometheus` (observability)

4. **Confirm the build works:**
   ```bash
   mvn clean compile
   ```

💡 **Pro Tip**: Modern LLMs understand migration dependencies. When you request a Spring Boot 3 upgrade, they automatically apply related changes like namespace migrations!

### Step 4: Convert Controllers to Reactive (10 minutes)

**Use Copilot Inline Chat for reactive transformation:**

1. **Open `TournamentController.java`**

2. **Select the entire controller class**

3. **Use Inline Chat** (`Ctrl+I` or `Cmd+I`):

   ```
   Convert to reactive: use Spring WebFlux with Flux for collections, Mono for single objects, constructor injection, proper error handling with defaultIfEmpty()
   ```

4. **Switch model if needed:**
   - Use **Claude 3.5 Sonnet** for reactive patterns (handles async code well)
   - Or **GPT-4o** for balanced approach


5. **Key Changes Copilot Applied:**
   - `List<T>` → `Flux<T>` (streaming multiple items)
   - `T` → `Mono<T>` (single async result)
   - Added proper error handling with `.defaultIfEmpty()`
   - Constructor injection instead of `@Autowired`

7. **Modernize the Service Layer too:**

   Open `TournamentService.java`, select the class, and use Inline Chat:
   ```
   Convert service methods to reactive: return Mono and Flux, use reactive repository calls, add proper error handling
   ```

   Copilot will transform blocking service methods to reactive:
   ```java
   @Service
   public class TournamentService {
       private final TournamentRepository repository;
       
       public TournamentService(TournamentRepository repository) {
           this.repository = repository;
       }
       
       public Mono<Tournament> findById(Long id) {
           return repository.findById(id);
       }
       
       public Flux<Tournament> findAll() {
           return repository.findAll();
       }
       
       public Mono<Tournament> save(Tournament tournament) {
           return repository.save(tournament);
       }
   }
   ```

### Step 5: Verify Repository Auto-Migration (2 minutes)

**⚡ Copilot Intelligence: When you asked for "reactive data (r2dbc)" in Step 2, Copilot likely converted your repositories to reactive automatically!**

**Verify what Copilot already completed:**

1. **Open `TournamentRepository.java`**

2. **Check the reactive transformation:**

   Verify it shows:
   ```java
   @Repository
   public interface TournamentRepository extends ReactiveCrudRepository<Tournament, Long> {
       Flux<Tournament> findByStatus(TournamentStatus status);
       Flux<Tournament> findByGame(String game);
       // All methods return Mono or Flux
   }
   ```

3. **Confirm the migration:**
   - ✅ `JpaRepository` → `ReactiveCrudRepository`
   - ✅ `List<T>` → `Flux<T>`
   - ✅ Single objects → `Mono<T>`
   - ✅ Comment shows "Reactive R2DBC Repository - NON-BLOCKING I/O"

4. **Check entity annotations:**

   Open `Tournament.java` and verify:
   ```java
   @Table("tournaments")  // R2DBC annotation, not @Entity
   public class Tournament {
       @Id
       private Long id;
       // ... other fields
   }
   ```

5. **If NOT auto-migrated, use Copilot Inline Chat:**
   ```
   Convert from JpaRepository to ReactiveCrudRepository with R2DBC. Update all method return types to Flux or Mono.
   ```

6. **Verify the build:**
   ```bash
   mvn clean compile
   ```

💡 **Pro Tip**: Copilot understands dependency chains. Requesting "reactive data (r2dbc)" triggers repository pattern updates automatically!

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

### Step 7: Test the Modernized Service (5 minutes)

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

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Application starts successfully on port 8080
- [ ] All endpoints return data reactively (Mono/Flux)
- [ ] Health check returns UP status with reactive components
- [ ] Metrics endpoint shows Prometheus format data
- [ ] No blocking I/O in controllers or services
- [ ] Build completes successfully with `mvn clean install`

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

1. **Model Selection** matters - Choose GPT-4 for analysis, Claude 3.5 Sonnet for reactive code patterns
2. **@workspace** helps analyze entire projects with context awareness
3. **Inline Chat** (`Ctrl+I`) is powerful for targeted code transformations
4. **Copilot Edits** (`Ctrl+Shift+I`) enables batch modifications across multiple files
5. **Reactive Programming** (WebFlux) provides better scalability for I/O-bound operations
6. **Spring Boot 3.x requires Java 17+** and Jakarta EE namespace migration
7. **Actuator + Prometheus** provide production-ready observability
8. **GitHub Copilot accelerates modernization** by 60-70% vs manual migration

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
