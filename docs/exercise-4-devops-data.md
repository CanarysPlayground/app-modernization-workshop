# Exercise 4: DevOps & Data Engineering Pipeline ⚙️📊

**Duration**: 20 minutes  
**Difficulty**: ⭐⭐⭐⭐ Advanced  
**Prerequisites**: Docker, Python 3.11+, GitHub Actions knowledge

## 🎮 The Challenge

Game Arena Legends has **three modernized services** (Java, .NET, Angular) but no automation or data analytics! You need to:

1. **Containerize all services** for cloud deployment
2. **Set up CI/CD pipelines** with GitHub Actions
3. **Build a data engineering pipeline** for match analytics
4. **Deploy everything to the cloud**

Your mission: **Create a complete DevOps & Data Engineering solution using containers, automation, and modern data tools.**

## 📋 What You'll Learn

- ✅ Containerize microservices with Docker
- ✅ Create multi-stage Docker builds
- ✅ Set up GitHub Actions for CI/CD
- ✅ Build data pipelines with Python & dbt
- ✅ Deploy to Azure Container Apps
- ✅ Use GitHub Copilot for infrastructure as code

## 🏗️ Architecture Overview

**Target Architecture:**
```
GitHub Actions (CI/CD)
├── Build & Test All Services
├── Build Docker Images
├── Push to Container Registry
└── Deploy to Azure Container Apps

Data Pipeline
├── Extract: Match data from APIs
├── Transform: dbt models
├── Load: Data warehouse (PostgreSQL)
└── Visualize: Dashboard (optional)
```

## 🚀 Part A: Containerization (8 minutes)

### Step 1: Dockerize Java Tournament Service (3 minutes)

Create [legacy-code/java-tournament-service/Dockerfile](../legacy-code/java-tournament-service/Dockerfile):

```dockerfile
# Multi-stage build for Java Spring Boot
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy JAR from builder
COPY --from=builder /app/target/*.jar app.jar

# Create non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Use GitHub Copilot to optimize:**
```
@workspace Optimize this Dockerfile for faster builds and smaller image size
```

**Build and test:**
```bash
cd legacy-code/java-tournament-service
docker build -t tournament-service:latest .
docker run -p 8080:8080 tournament-service:latest
```

### Step 2: Dockerize .NET Stats API (3 minutes)

Create [modernized-code/dotnet-stats-api/Dockerfile](../modernized-code/dotnet-stats-api/Dockerfile):

```dockerfile
# Multi-stage build for .NET 8
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder

WORKDIR /source
COPY PlayerStatsAPI/*.csproj ./PlayerStatsAPI/
RUN dotnet restore PlayerStatsAPI/PlayerStatsAPI.csproj

COPY PlayerStatsAPI/ ./PlayerStatsAPI/
WORKDIR /source/PlayerStatsAPI
RUN dotnet publish -c Release -o /app --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

WORKDIR /app
COPY --from=builder /app .

# Create non-root user
RUN addgroup -S dotnet && adduser -S dotnet -G dotnet
USER dotnet

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "PlayerStatsAPI.dll"]
```

**Build and test:**
```bash
cd modernized-code/dotnet-stats-api
docker build -t stats-api:latest .
docker run -p 5000:5000 stats-api:latest
```

### Step 3: Dockerize Angular Dashboard (2 minutes)

Create [modernized-code/angular-dashboard/Dockerfile](../modernized-code/angular-dashboard/Dockerfile):

```dockerfile
# Build stage
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build:ssr

# Runtime stage
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

RUN npm ci --production

EXPOSE 4000

CMD ["node", "dist/server/server.mjs"]
```

**Build and test:**
```bash
cd modernized-code/angular-dashboard
docker build -t dashboard:latest .
docker run -p 4000:4000 dashboard:latest
```

## 🚀 Part B: CI/CD with GitHub Actions (7 minutes)

### Step 4: Create GitHub Actions Workflow (7 minutes)

Create [.github/workflows/main.yml](../.github/workflows/main.yml):

```yaml
name: Game Arena CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  REGISTRY: ghcr.io
  IMAGE_PREFIX: ${{ github.repository }}

jobs:
  # Job 1: Build and Test Java Service
  build-java:
    name: Build Java Tournament Service
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./legacy-code/java-tournament-service

    steps:
      - uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: 'maven'

      - name: Build with Maven
        run: mvn clean install -DskipTests

      - name: Run Tests
        run: mvn test

      - name: Build Docker Image
        run: |
          docker build -t tournament-service:${{ github.sha }} .
          docker tag tournament-service:${{ github.sha }} tournament-service:latest

      - name: Save Docker Image
        run: docker save tournament-service:latest | gzip > tournament-service.tar.gz

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: tournament-service-image
          path: ./legacy-code/java-tournament-service/tournament-service.tar.gz

  # Job 2: Build and Test .NET Service
  build-dotnet:
    name: Build .NET Stats API
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./modernized-code/dotnet-stats-api

    steps:
      - uses: actions/checkout@v4

      - name: Setup .NET 8
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '8.0.x'

      - name: Restore Dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --no-restore -c Release

      - name: Test
        run: dotnet test --no-build --verbosity normal

      - name: Build Docker Image
        run: |
          docker build -t stats-api:${{ github.sha }} .
          docker tag stats-api:${{ github.sha }} stats-api:latest

  # Job 3: Build and Test Angular Dashboard
  build-angular:
    name: Build Angular Dashboard
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./modernized-code/angular-dashboard

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
          cache-dependency-path: ./modernized-code/angular-dashboard/package-lock.json

      - name: Install Dependencies
        run: npm ci

      - name: Lint
        run: npm run lint --if-present

      - name: Build
        run: npm run build:ssr

      - name: Test
        run: npm test -- --watch=false --browsers=ChromeHeadless

      - name: Build Docker Image
        run: docker build -t dashboard:latest .

  # Job 4: Security Scan
  security-scan:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: [build-java, build-dotnet, build-angular]

    steps:
      - uses: actions/checkout@v4

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload Trivy results to GitHub Security
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: 'trivy-results.sarif'

  # Job 5: Deploy (only on main branch)
  deploy:
    name: Deploy to Azure
    runs-on: ubuntu-latest
    needs: [build-java, build-dotnet, build-angular, security-scan]
    if: github.ref == 'refs/heads/main'

    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Deploy to Azure Container Apps
        run: |
          echo "Deploying tournament-service..."
          az containerapp up \
            --name tournament-service \
            --resource-group game-arena-rg \
            --location eastus \
            --image ghcr.io/${{ github.repository }}/tournament-service:latest

          echo "Deploying stats-api..."
          az containerapp up \
            --name stats-api \
            --resource-group game-arena-rg \
            --location eastus \
            --image ghcr.io/${{ github.repository }}/stats-api:latest

      - name: Run Smoke Tests
        run: |
          curl -f https://tournament-service.azurecontainerapps.io/health || exit 1
          curl -f https://stats-api.azurecontainerapps.io/health || exit 1
```

**Use GitHub Copilot to enhance:**
```
@workspace Add code coverage reports and deploy previews to this GitHub Actions workflow
```

## 🚀 Part C: Data Engineering Pipeline (5 minutes)

### Step 5: Build ETL Pipeline with Python (5 minutes)

Create [legacy-code/data-pipeline/extract.py](../legacy-code/data-pipeline/extract.py):

```python
"""
Extract match data from Game Arena APIs
"""
import httpx
import polars as pl
from datetime import datetime, timedelta
import asyncio
from typing import List, Dict

class GameArenaExtractor:
    def __init__(self, base_url: str = "http://localhost:8080"):
        self.base_url = base_url
        self.client = httpx.AsyncClient(timeout=30.0)

    async def extract_tournaments(self) -> pl.DataFrame:
        """Extract tournament data"""
        response = await self.client.get(f"{self.base_url}/api/tournaments")
        response.raise_for_status()
        data = response.json()
        
        return pl.DataFrame(data)

    async def extract_players(self, limit: int = 100) -> pl.DataFrame:
        """Extract player statistics"""
        response = await self.client.get(
            f"http://localhost:5000/api/players/leaderboard?limit={limit}"
        )
        response.raise_for_status()
        data = response.json()
        
 return pl.DataFrame(data)

    async def extract_all(self) -> Dict[str, pl.DataFrame]:
        """Extract all data sources"""
        tournaments_df, players_df = await asyncio.gather(
            self.extract_tournaments(),
            self.extract_players()
        )
        
        return {
            "tournaments": tournaments_df,
            "players": players_df,
            "extracted_at": datetime.utcnow().isoformat()
        }

    async def close(self):
        await self.client.aclose()

async def main():
    extractor = GameArenaExtractor()
    try:
        data = await extractor.extract_all()
        
        # Save to parquet for downstream processing
        data["tournaments"].write_parquet("data/raw/tournaments.parquet")
        data["players"].write_parquet("data/raw/players.parquet")
        
        print(f"✅ Extracted {len(data['tournaments'])} tournaments")
        print(f"✅ Extracted {len(data['players'])} players")
    finally:
        await extractor.close()

if __name__ == "__main__":
    asyncio.run(main())
```

Create [legacy-code/data-pipeline/transform.py](../legacy-code/data-pipeline/transform.py):

```python
"""
Transform and enrich match data
"""
import polars as pl
from pathlib import Path

def transform_tournament_data():
    """Transform tournament data with analytics"""
    df = pl.read_parquet("data/raw/tournaments.parquet")
    
    # Add computed columns
    transformed = df.with_columns([
        pl.col("startDate").str.strptime(pl.Datetime, "%Y-%m-%dT%H:%M:%S").alias("start_datetime"),
        (pl.col("currentParticipants") / pl.col("maxParticipants") * 100).alias("fill_rate"),
        pl.when(pl.col("status") == "IN_PROGRESS")
            .then(pl.lit("Active"))
            .when(pl.col("status") == "UPCOMING")
            .then(pl.lit("Scheduled"))
            .otherwise(pl.lit("Completed"))
            .alias("status_category")
    ])
    
    return transformed

def transform_player_data():
    """Transform player data with rankings"""
    df = pl.read_parquet("data/raw/players.parquet")
    
    transformed = df.with_columns([
        (pl.col("wins") / pl.col("totalMatches") * 100).alias("win_rate"),
        pl.col("eloRating").rank("dense", descending=True).alias("rank"),
        pl.when(pl.col("eloRating") >= 2000)
            .then(pl.lit("Master"))
            .when(pl.col("eloRating") >= 1800)
            .then(pl.lit("Diamond"))
            .when(pl.col("eloRating") >= 1500)
            .then(pl.lit("Platinum"))
            .otherwise(pl.lit("Gold"))
            .alias("tier")
    ])
    
    return transformed

def main():
    # Transform data
    tournaments = transform_tournament_data()
    players = transform_player_data()
    
    # Save transformed data
    Path("data/processed").mkdir(parents=True, exist_ok=True)
    tournaments.write_parquet("data/processed/tournaments.parquet")
    players.write_parquet("data/processed/players.parquet")
    
    print(f"✅ Transformed {len(tournaments)} tournaments")
    print(f"✅ Transformed {len(players)} players")
    
    # Summary statistics
    print("\n📊 Tournament Summary:")
    print(tournaments.group_by("status_category").agg(pl.count()))
    
    print("\n📊 Player Tier Distribution:")
    print(players.group_by("tier").agg(pl.count()))

if __name__ == "__main__":
    main()
```

**Create requirements.txt:**
```txt
httpx==0.27.0
polars==0.20.0
duckdb==0.10.0
```

**Use GitHub Copilot for enhancement:**
```
@workspace Add data quality checks and error handling to this ETL pipeline
```

## ✅ Success Criteria

Your DevOps & Data setup is complete when:

- [ ] All services have working Dockerfiles
- [ ] Docker containers run successfully locally
- [ ] GitHub Actions workflow passes all jobs
- [ ] ETL pipeline extracts and transforms data
- [ ] Data is saved to parquet files
- [ ] All tests pass in CI/CD
- [ ] Security scans show no critical issues

## 🎯 Validation Commands

```bash
# Test Docker builds
docker build -t tournament-service legacy-code/java-tournament-service
docker build -t stats-api modernized-code/dotnet-stats-api
docker build -t dashboard modernized-code/angular-dashboard

# Run all containers
docker-compose up -d

# Test APIs
curl http://localhost:8080/health
curl http://localhost:5000/health
curl http://localhost:4000

# Run ETL pipeline
cd legacy-code/data-pipeline
python extract.py
python transform.py

# Validate GitHub Actions locally (optional)
act -j build-java
```

## 🐛 Troubleshooting

### Issue 1: Docker build fails
**Solution**: Check Docker daemon is running
```bash
docker version
docker system prune -a
```

### Issue 2: GitHub Actions timeout
**Solution**: Use caching for dependencies
```yaml
- uses: actions/cache@v4
  with:
    path: ~/.m2
    key: ${{ runner.os }}-maven-${{ hashFiles('**/pom.xml') }}
```

### Issue 3: Data pipeline connection errors
**Solution**: Ensure services are running first
```bash
docker-compose up -d
sleep 10  # Wait for services to start
python extract.py
```

## 🎓 Key Takeaways

1. **Multi-stage Docker builds** reduce image size by 60-80%
2. **GitHub Actions** provides free CI/CD for public repos
3. **Polars** is 10x faster than Pandas for data processing
4. **Container orchestration** simplifies deployment
5. **Automated pipelines** reduce human error

## 📚 Additional Resources

- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure Container Apps](https://learn.microsoft.com/en-us/azure/container-apps/)
- [Polars Documentation](https://pola-rs.github.io/polars/)

## 🎉 Congratulations!

You've completed all 4 exercises! You've successfully:
- ✅ Modernized Java Spring Boot service
- ✅ Migrated .NET API to .NET 8
- ✅ Upgraded Angular to v18
- ✅ Built complete DevOps & Data pipeline

---

**⚙️ Achievement Unlocked: DevOps & Data Engineering Champion!**

**[Back to Workshop Home](README.md)** | **[View Summary](../README.md#workshop-summary)**
