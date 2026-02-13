# 🤖 Using GitHub Copilot App Modernization Extensions

This guide shows you how to use the **official GitHub Copilot App Modernization extensions** throughout the workshop.

## 📦 Required Extensions

### For All Exercises
- **GitHub Copilot Chat** (`GitHub.copilot-chat`)
  - Core chat functionality
  - Inline code suggestions

### For Java (Exercise 1)
- **GitHub Copilot App Modernization** (`vscjava.migrate-java-to-azure`)
  - Analyzes Java projects for Azure migration
  - Provides upgrade recommendations
  
- **GitHub Copilot App Modernization - Java Upgrade** (`vscjava.vscode-java-upgrade`)
  - Automated Spring Boot version upgrades
  - Dependency analysis and updates
  - Breaking change detection

### For .NET (Exercise 2)
- **GitHub Copilot App Modernization for .NET** (`ms-dotnettools.vscodedotnet-modernize`)
  - .NET Framework to .NET 8 assessment
  - API compatibility analysis
  - Step-by-step migration guidance

---

## 🚀 Installation

### Quick Install (All Extensions)
```bash
# Open VS Code Command Palette (Ctrl+Shift+P / Cmd+Shift+P)
# Run each command:
ext install GitHub.copilot-chat
ext install vscjava.migrate-java-to-azure
ext install vscjava.vscode-java-upgrade
ext install ms-dotnettools.vscodedotnet-modernize
```

### Manual Install
1. Open VS Code Extensions panel (`Ctrl+Shift+X` / `Cmd+Shift+X`)
2. Search for each extension name
3. Click **Install**
4. Restart VS Code

### Verify Installation
After installing, verify extensions are active:
1. Open Copilot Chat (`Ctrl+Alt+I` / `Cmd+Alt+I`)
2. Type `@workspace` and you should see agent options
3. Right-click on a Java/C# file - you should see Copilot modernization options

---

## 📚 Extension Features by Exercise

### Exercise 1: Java Tournament Service

#### **Feature 1: Project Assessment**

**Via Right-Click Menu:**
1. Right-click on `pom.xml`
2. Select **"Copilot: Analyze for Java Upgrade"**
3. View automated assessment report

**Via Chat Command:**
```
@workspace /agent AppModernization-Java analyze this Spring Boot project
```

**What It Provides:**
- ✓ Current Spring Boot version detected
- ✓ Recommended target version (3.2+)
- ✓ Deprecated dependency list
- ✓ Breaking changes identified
- ✓ Migration complexity score (Easy/Medium/Hard)

#### **Feature 2: Automated Dependency Updates**

**Interactive Upgrade:**
1. Open `pom.xml`
2. Look for Copilot lightbulb suggestions (💡)
3. Click suggested actions like:
   - "Update to Spring Boot 3.2"
   - "Replace deprecated dependencies"
   - "Migrate javax to jakarta"

**Chat-Based Update:**
```
Update pom.xml to Spring Boot 3.2 with all compatible dependencies
```

#### **Feature 3: Code Transformation**

**Convert Controller to Reactive:**
1. Select your controller method
2. Right-click → **"Copilot: Transform Code"**
3. Choose "Convert to Reactive (WebFlux)"

**Or use inline chat** (`Ctrl+I` / `Cmd+I`):
```
Convert this blocking controller method to reactive WebFlux with Mono/Flux
```

#### **Feature 4: Migration Progress Tracking**

The extension tracks your migration:
- Shows progress bar in status bar
- Highlights remaining deprecated code
- Provides next-step recommendations

---

### Exercise 2: .NET Player Stats API

#### **Feature 1: .NET Framework Assessment**

**Automated Assessment:**
1. Right-click on project folder
2. Select **"Copilot: Assess for .NET Modernization"**
3. Wait for analysis (30-60 seconds)

**Assessment Report Includes:**
```
✓ Current Framework: .NET Framework 4.8
✓ Recommended Target: .NET 8.0
✓ Incompatible APIs: 12 found
✓ Migration Effort: Medium (4-6 hours)
✓ Blockers: None
```

**Via Chat:**
```
@workspace /agent AppModernization-DotNet assess this project for .NET 8 migration
```

#### **Feature 2: API Modernization Suggestions**

**Convert to Minimal APIs:**
1. Open a controller file (e.g., `PlayersController.cs`)
2. Look for Copilot suggestions
3. Accept "Convert to Minimal API" suggestion

**Chat Command:**
```
Convert this ASP.NET Web API controller to .NET 8 minimal API pattern
```

#### **Feature 3: Step-by-Step Migration Plan**

The extension generates a migration plan:

```
Step 1: Create new .NET 8 project
Step 2: Migrate models and entities
Step 3: Update Entity Framework to EF Core
Step 4: Convert controllers to minimal APIs
Step 5: Update dependency injection
Step 6: Test and validate
```

Each step includes:
- Code examples
- Common pitfalls
- Testing strategies

#### **Feature 4: Entity Framework Migration**

**EF6 to EF Core:**
1. Open `DbContext` file
2. Right-click → **"Copilot: Modernize Entity Framework"**
3. Review and apply suggested changes

---

### Exercise 3: Angular Dashboard

While there's no specific Angular extension, use **GitHub Copilot Chat** effectively:

**Angular Upgrade Analysis:**
```
@workspace Analyze this Angular 12 project and provide upgrade path to Angular 18
```

**Component Modernization:**
```
Convert this NgModule component to Angular 18 standalone component with signals
```

---

## 🎯 Best Practices

### 1. Always Start with Assessment
Before making changes:
```
@workspace /agent AppModernization-[Java|DotNet] assess this project
```

### 2. Review Before Accepting
- Don't blindly accept all suggestions
- Read the changes
- Understand the impact
- Test incrementally

### 3. Use Inline Chat for Targeted Changes
- Select specific code blocks
- Press `Ctrl+I` / `Cmd+I`
- Ask focused questions

### 4. Leverage Context
The extensions understand:
- Your project structure
- Current dependencies
- Code patterns
- Best practices

### 5. Iterate in Small Steps
✅ **Good approach:**
1. Update dependencies
2. Fix compilation errors
3. Migrate one controller
4. Test
5. Repeat

❌ **Bad approach:**
1. Try to change everything at once
2. Hope it works

---

## 🔍 Troubleshooting

### Extension Not Showing in Context Menu

**Solution:**
1. Ensure extension is installed and enabled
2. Reload VS Code window (`Ctrl+Shift+P` → "Reload Window")
3. Check extension is activated (look for icon in status bar)
4. Verify file type is correct (Java/C# files)

### Agent Not Responding in Chat

**Solution:**
```
# Correct format:
@workspace /agent AppModernization-Java analyze project

# NOT:
@AppModernization-Java (missing @workspace)
```

### Assessment Takes Too Long

**Solution:**
- Large projects (500+ files) may take 2-3 minutes
- Check VS Code output panel for progress
- Ensure stable internet connection (agents run in cloud)

### Suggestions Not Appearing

**Solution:**
1. Check GitHub Copilot subscription is active
2. Sign out and sign back into GitHub in VS Code
3. Check VS Code settings: `github.copilot.enable` = true
4. Restart VS Code

---

## 💡 Pro Tips

### Tip 1: Use Conversation History
Copilot remembers your conversation:
```
User: @workspace assess this Java project
Copilot: [provides assessment]
User: Now help me update the dependencies
Copilot: [uses context from assessment]
```

### Tip 2: Ask Follow-Up Questions
```
User: Convert this controller to reactive
Copilot: [provides code]
User: How do I test this reactive code?
Copilot: [provides test examples]
```

### Tip 3: Request Multiple Alternatives
```
Show me 3 different ways to migrate this Entity Framework code to EF Core
```

### Tip 4: Ask for Explanations
```
Explain why you changed this code from blocking to reactive
```

### Tip 5: Generate Documentation
```
Generate migration documentation for the changes you suggested
```

---

## 📊 Extension Comparison

| Feature | Java Extensions | .NET Extension | Regular Copilot |
|---------|----------------|----------------|-----------------|
| **Project Assessment** | ✅ Automated | ✅ Automated | ❌ Manual |
| **Dependency Analysis** | ✅ Full | ✅ Full | ⚠️ Partial |
| **Step-by-Step Plan** | ✅ Yes | ✅ Yes | ❌ No |
| **Code Transformation** | ✅ Automated | ✅ Automated | ⚠️ Suggested |
| **Progress Tracking** | ✅ Yes | ✅ Yes | ❌ No |
| **Migration Validation** | ✅ Yes | ✅ Yes | ❌ No |
| **Azure Integration** | ✅ Built-in | ✅ Built-in | ❌ Manual |

---

## 🎓 Learning More

### Official Documentation
- [GitHub Copilot App Modernization](https://marketplace.visualstudio.com/items?itemName=vscjava.migrate-java-to-azure)
- [Java Upgrade Extension](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-upgrade)
- [.NET Modernization Extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.vscodedotnet-modernize)

### Video Tutorials
- Search YouTube: "GitHub Copilot App Modernization"
- Microsoft Learn modules on app modernization

### Community Resources
- GitHub Discussions for each extension
- Stack Overflow tag: `github-copilot`

---

## 🚀 Workshop Usage

### Exercise 1 (Java)
**Primary Extension:** Java Upgrade (`vscjava.vscode-java-upgrade`)

**Key Commands:**
```bash
# Step 1: Assess
Right-click pom.xml → "Analyze for Java Upgrade"

# Step 2: Plan
@workspace /agent AppModernization-Java create migration plan

# Step 3: Execute
Follow suggested steps in sequential order

# Step 4: Validate
Run tests and check for deprecated warnings
```

### Exercise 2 (.NET)
**Primary Extension:** .NET Modernization (`ms-dotnettools.vscodedotnet-modernize`)

**Key Commands:**
```bash
# Step 1: Assess
Right-click project → "Assess for .NET Modernization"

# Step 2: Review
Read assessment report and migration plan

# Step 3: Execute
Create new .NET 8 project and migrate code

# Step 4: Test
Compare API responses with original
```

---

## ✅ Quick Reference

### Most Common Commands

**Java:**
```
@workspace /agent AppModernization-Java analyze this Spring Boot project
@workspace /agent AppModernization-Java suggest dependency updates
@workspace /agent AppModernization-Java create migration plan
```

**NET:**
```
@workspace /agent AppModernization-DotNet assess this .NET project
@workspace /agent AppModernization-DotNet suggest minimal API conversion
@workspace /agent AppModernization-DotNet identify incompatible APIs
```

**General:**
```
@workspace analyze project structure
@workspace find deprecated code patterns
@workspace generate migration documentation
```

---

**🎉 You're now ready to use the GitHub Copilot App Modernization extensions effectively throughout the workshop!**
