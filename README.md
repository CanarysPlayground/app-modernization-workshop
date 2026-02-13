# 🏆 Game Arena Legends - App Modernization Workshop

![Workshop Banner](https://img.shields.io/badge/Duration-2%20Hours-blue) ![Difficulty](https://img.shields.io/badge/Level-Intermediate-orange) ![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-Enabled-green)

## 📖 The Story

Welcome to **Game Arena Legends**, the world's premier esports tournament management platform! Founded in 2010, our platform has been managing tournaments for games like League of Legends, Dota 2, CS:GO, and Valorant. However, our legacy codebase is holding us back from delivering the next-generation features our players and tournament organizers demand.

As a newly hired **Cloud Modernization Engineer** at Game Arena Legends, your mission is to modernize our legacy systems across multiple technology stacks. The championship season is approaching, and we need to ensure our platform can handle millions of concurrent users while providing real-time analytics and a seamless user experience.

## 🎯 Workshop Objectives

By the end of this 2-hour workshop, you will:

- ✅ Master GitHub Copilot agents (GitHub Copilot Agent Mode, custom agents) for app modernization
- ✅ Modernize legacy Java, .NET, Angular, and DevOps/Data pipelines
- ✅ Apply best practices for code refactoring, testing, and deployment
- ✅ Learn migration patterns from monoliths to microservices
- ✅ Implement CI/CD automation for modern cloud platforms

## 🛠️ Prerequisites

### Required Tools
- **Visual Studio Code** (latest version)
- **GitHub Copilot** subscription (individual, business, or enterprise)
- **Git** (v2.40+)
- **Docker Desktop** (for containerization exercises)

### Required VS Code Extensions
- **GitHub Copilot Chat** (`GitHub.copilot-chat`)
- **GitHub Copilot App Modernization** (`vscjava.migrate-java-to-azure`)
- **GitHub Copilot App Modernization - Java Upgrade** (`vscjava.vscode-java-upgrade`)
- **GitHub Copilot App Modernization for .NET** (`ms-dotnettools.vscodedotnet-modernize`)

### Language-Specific Requirements
- **Java**: JDK 17+ and Maven 3.8+
- **.NET**: .NET 8.0 SDK
- **Angular**: Node.js 20+ and npm 10+
- **Python**: Python 3.11+ (for data engineering exercise)

### Accounts
- GitHub account with Copilot enabled
- Azure subscription (free tier works) for deployment exercises

## 📚 Workshop Structure (2 Hours)

| Time | Duration | Exercise | What You'll Learn |
|------|----------|----------|-------------------|
| 0:00-0:10 | 10 min | Introduction & Setup | Workshop overview, tools verification |
| 0:10-0:40 | 30 min | [Exercise 1: Java Backend Modernization](./docs/exercise-1-java.md) | Migrate Spring Boot 2.x → 3.x, add reactive patterns |
| 0:40-1:10 | 30 min | [Exercise 2: .NET API Modernization](./docs/exercise-2-dotnet.md) | Migrate .NET Framework → .NET 8, minimal APIs |
| 1:10-1:30 | 20 min | [Exercise 3: Angular Frontend Modernization](./docs/exercise-3-angular.md) | Upgrade Angular 12 → 18, signals & standalone components |
| 1:30-1:50 | 20 min | [Exercise 4: DevOps & Data Pipeline](./docs/exercise-4-devops-data.md) | Containerize apps, set up GitHub Actions, ETL pipeline |
| 1:50-2:00 | 10 min | Wrap-up & Q&A | Key takeaways, next steps |

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd App_modernization
```

### Step 2: Verify Your Setup

Run the setup verification script:

```bash
# Windows PowerShell
.\scripts\verify-setup.ps1

# macOS/Linux
./scripts/verify-setup.sh
```

### Step 3: Install GitHub Copilot App Modernization Extensions

**Quick Install:**
```bash
# Open VS Code and run (Ctrl+P or Cmd+P):
ext install vscjava.migrate-java-to-azure
ext install vscjava.vscode-java-upgrade
ext install ms-dotnettools.vscodedotnet-modernize
ext install GitHub.copilot-chat
```

**Or install manually:**
1. Open VS Code Extensions (Ctrl+Shift+X)
2. Search and install:
   - "GitHub Copilot app modernization" (general)
   - "GitHub Copilot app modernization - upgrade for Java"
   - "GitHub Copilot app modernization for .NET"
   - "GitHub Copilot Chat"
3. Restart VS Code after installation

### Step 4: Start the Workshop

Navigate to the [Workshop Introduction](./docs/README.md) to begin your modernization journey!

**💡 Pro Tip:** Check out [EXTENSION_GUIDE.md](./docs/EXTENSION_GUIDE.md) for detailed instructions on using the GitHub Copilot App Modernization extensions effectively!

## 🏗️ Project Architecture

```
Game Arena Legends Platform
├── Tournament Service (Java/Spring Boot)      ← Exercise 1
├── Player Stats API (.NET/C#)                 ← Exercise 2
├── Tournament Dashboard (Angular)             ← Exercise 3
└── DevOps & Data Analytics Pipeline           ← Exercise 4
```

## 📂 Repository Structure

```
App_modernization/
├── README.md                           # This file
├── docs/                               # Workshop exercises
│   ├── README.md                       # Introduction & navigation
│   ├── exercise-1-java.md
│   ├── exercise-2-dotnet.md
│   ├── exercise-3-angular.md
│   └── exercise-4-devops-data.md
├── legacy-code/                        # Starting point for each exercise
│   ├── java-tournament-service/        # Exercise 1 code
│   ├── dotnet-stats-api/              # Exercise 2 code
│   ├── angular-dashboard/             # Exercise 3 code
│   └── data-pipeline/                 # Exercise 4 code
├── modernized-code/                   # Reference solutions
│   ├── java-tournament-service/
│   ├── dotnet-stats-api/
│   ├── angular-dashboard/
│   └── data-pipeline/
└── scripts/                           # Setup and utility scripts
    ├── verify-setup.ps1
    ├── verify-setup.sh
    └── deploy-all.sh
```

## 🎓 Learning Paths

### Path 1: Backend Developer
Focus on **Exercise 1 (Java)** and **Exercise 2 (.NET)** to master API modernization patterns.

### Path 2: Frontend Developer
Start with **Exercise 3 (Angular)** to learn modern frontend architecture.

### Path 3: DevOps Engineer
Jump to **Exercise 4** for containerization, CI/CD, and infrastructure automation.

### Path 4: Full-Stack Developer
Complete all exercises in sequence for end-to-end modernization experience.


## 📖 Additional Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [App Modernization with GitHub Copilot](https://docs.github.com/en/copilot/tutorials/modernize-java-applications)
- [GitHub Copilot for Java & .NET](https://github.blog/changelog/2025-09-22-github-copilot-app-modernization-is-now-generally-available-for-java-and-net/)
- [Microsoft Learn: C++ App Modernization](https://learn.microsoft.com/en-us/cpp/porting/copilot-app-modernization-cpp?view=msvc-170)
- [Azure Developer: GitHub Copilot App Modernization](https://learn.microsoft.com/en-us/azure/developer/github-copilot-app-modernization/overview)
- [Tailspin Toys - SDLC Agents Workshop](https://github.com/sombaner/agents-in-sdlc)

---

**Ready to modernize Game Arena Legends?** Head over to [docs/README.md](./docs/README.md) to start your journey! 🚀
