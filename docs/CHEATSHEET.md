# Game Arena Legends - Workshop Cheatsheet 🎮

## Quick Reference for All Exercises

---

## 🚀 Exercise 1: Java (Spring Boot)

### Key Commands
```bash
# Update Spring Boot version in pom.xml
mvn versions:update-parent

# Build
mvn clean install

# Run
mvn spring-boot:run

# Test
mvn test
```

### GitHub Copilot Prompts
```
@workspace Analyze this Spring Boot project and suggest Spring Boot 3.x migration steps

Convert this blocking Spring Boot controller to reactive WebFlux with Mono and Flux

Update this pom.xml to Spring Boot 3.2, Java 17, and add WebFlux dependencies
```

### Key Migration Steps
1. Update `pom.xml`: Spring Boot 2.7 → 3.2, Java 11 → 17
2. Replace `javax.*` with `jakarta.*`
3. Convert controllers to reactive (use `Mono<T>` and `Flux<T>`)
4. Update repository to `ReactiveCrudRepository`
5. Add health checks with Actuator

---

## ⚡ Exercise 2: .NET

### Key Commands
```bash
# Create new .NET 8 project
dotnet new webapi -n PlayerStatsAPI -f net8.0

# Add packages
dotnet add package Microsoft.EntityFrameworkCore.InMemory

# Build
dotnet build

# Run
dotnet run

# Test
dotnet test
```

### GitHub Copilot Prompts
```
@workspace /agent AppModernization-DotNet assess this for .NET 8 migration

Convert this .NET Framework controller to .NET 8 minimal APIs

Migrate this Entity Framework 6 DbContext to EF Core
```

### Key Migration Steps
1. Create new .NET 8 project (can't upgrade Framework → Core in place)
2. Convert controllers to minimal APIs in `Program.cs`
3. Update Entity Framework → Entity Framework Core
4. Replace `DbContext` constructor and configuration
5. Add OpenAPI/Swagger documentation

---

## 🎨 Exercise 3: Angular

### Key Commands
```bash
# Update Angular
ng update @angular/core@18 @angular/cli@18 --force

# Generate standalone component
ng generate component my-component --standalone

# Build with SSR
npm run build:ssr

# Serve with SSR
npm run serve:ssr

# Regular serve
ng serve
```

### GitHub Copilot Prompts
```
@workspace Analyze this Angular project for Angular 18 upgrade

Convert this NgModule to standalone components

Replace this RxJS BehaviorSubject with Angular signals

@workspace Replace all *ngIf and *ngFor with @if and @for syntax
```

### Key Migration Steps
1. Run `ng update` to upgrade to Angular 18
2. Convert `app.module.ts` to `main.ts` with `bootstrapApplication`
3. Make components standalone (add `standalone: true`)
4. Replace RxJS state with signals
5. Update templates to use `@if` / `@for` syntax
6. Add SSR with `ng add @angular/ssr`

---

## ⚙️ Exercise 4: DevOps & Data

### Docker Commands
```bash
# Build image
docker build -t service-name:latest .

# Run container
docker run -p 8080:8080 service-name:latest

# Run all services
docker-compose up -d

# Stop all
docker-compose down

# View logs
docker logs container-name
```

### Data Pipeline Commands
```bash
# Install dependencies
pip install -r requirements.txt

# Run extraction
python extract.py

# Run transformation
python transform.py

# Query with DuckDB
duckdb data/processed/analytics.db
```

### GitHub Copilot Prompts
```
@workspace Create a multi-stage Dockerfile for this Spring Boot application

Optimize this Dockerfile for smaller image size and faster builds

Generate a GitHub Actions workflow for building and testing this project

Add data quality checks to this ETL pipeline
```

---

## 🤖 Universal GitHub Copilot Tips

### Workspace Agent
```
@workspace Find all deprecated API calls in this project

@workspace List all files that need migration

@workspace What's the structure of this codebase?
```

### Inline Chat (Ctrl+I / Cmd+I)
- Select code → `Ctrl+I` → Ask to refactor/modernize
- Example: "Convert this to use modern patterns"

### Chat (Ctrl+Alt+I / Cmd+Alt+I)
- General questions about the project
- "How do I migrate this service to containers?"

### App Modernization Agents
```
@workspace /agent AppModernization-Java analyze this project

@workspace /agent AppModernization-DotNet assess migration readiness
```

---

## 🔧 Troubleshooting

### Java Build Fails
```bash
# Clear Maven cache
rm -rf ~/.m2/repository
mvn clean install -U
```

### .NET Compilation Errors
```bash
# Clean and rebuild
dotnet clean
dotnet restore
dotnet build
```

### Angular Module Errors
```bash
# Clear cache
rm -rf node_modules package-lock.json
npm install
```

### Docker Issues
```bash
# Clean Docker
docker system prune -a

# Check logs
docker logs container-name --follow
```

---

## 📊 Time Management (2 Hour Workshop)

| Time | Exercise | Focus |
|------|----------|-------|
| 0:00-0:10 | Setup | Tools verification |
| 0:10-0:40 | Exercise 1 | Java/Spring Boot |
| 0:40-1:10 | Exercise 2 | .NET Core |
| 1:10-1:30 | Exercise 3 | Angular |
| 1:30-1:50 | Exercise 4 | DevOps/Data |
| 1:50-2:00 | Wrap-up | Q&A |

---

## 🎯 Success Checklist

### After Exercise 1
- [ ] Spring Boot 3.2 running
- [ ] Reactive WebFlux endpoints working
- [ ] Health check returns UP

### After Exercise 2
- [ ] .NET 8 running
- [ ] Minimal APIs responding
- [ ] Swagger UI accessible

### After Exercise 3
- [ ] Angular 18 running
- [ ] Standalone components working
- [ ] Signals updating UI

### After Exercise 4
- [ ] All services containerized
- [ ] Docker Compose runs all services
- [ ] ETL pipeline completes successfully

---

## 📚 Quick Links

- [Workshop Home](../README.md)
- [Exercise 1: Java](exercise-1-java.md)
- [Exercise 2: .NET](exercise-2-dotnet.md)
- [Exercise 3: Angular](exercise-3-angular.md)
- [Exercise 4: DevOps](exercise-4-devops-data.md)

---

**🏆 Keep this cheatsheet handy throughout the workshop!**
