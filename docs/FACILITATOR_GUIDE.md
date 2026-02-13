# 👨‍🏫 Workshop Facilitator Guide

**Workshop:** Game Arena Legends - App Modernization with GitHub Copilot  
**Duration:** 2 hours  
**Target Audience:** Intermediate to Advanced Developers  
**Prerequisites:** Java, .NET, or Angular experience

---

## 🎯 Learning Objectives

By the end of this workshop, participants will be able to:

1. **Assess** legacy applications for modernization opportunities
2. **Use GitHub Copilot agents** for automated code analysis and migration
3. **Migrate** Java, .NET, and Angular applications to modern versions
4. **Implement** reactive patterns, minimal APIs, and modern frameworks
5. **Containerize** applications with Docker
6. **Automate** CI/CD with GitHub Actions
7. **Build** data engineering pipelines

---

## 📅 Workshop Timeline

| Time | Section | Activity | Duration |
|------|---------|----------|----------|
| 0:00-0:10 | **Introduction** | Workshop overview, tools check | 10 min |
| 0:10-0:40 | **Exercise 1** | Java/Spring Boot modernization | 30 min |
| 0:40-1:10 | **Exercise 2** | .NET API modernization | 30 min |
| 1:10-1:30 | **Exercise 3** | Angular frontend modernization | 20 min |
| 1:30-1:50 | **Exercise 4** | DevOps & data pipeline | 20 min |
| 1:50-2:00 | **Wrap-up** | Q&A, certificates, next steps | 10 min |

---

## 🎪 Pre-Workshop Setup (1 Week Before)

### Send to Participants:
- [ ] Workshop registration confirmation
- [ ] Prerequisites list (tools to install)
- [ ] GitHub Copilot access requirements
- [ ] Pre-workshop survey (skill level, interests)
- [ ] Calendar invite with Zoom/Teams link

### Email Template:
```
Subject: Game Arena Legends Workshop - Setup Instructions

Hi [Name],

You're registered for the App Modernization Workshop on [Date]!

BEFORE THE WORKSHOP:
1. Install required tools (see attached checklist)
2. Verify GitHub Copilot access
3. Clone the workshop repository: [URL]
4. Run setup verification: ./scripts/verify-setup.sh

See you on [Date] at [Time]!

Questions? Reply to this email.

Cheers,
[Your Name]
```

---

## 🚀 Day-Of Setup (30 Minutes Before)

### Technical Setup:
- [ ] Test screen sharing
- [ ] Open all exercises in VS Code
- [ ] Have ChatGPT/Copilot ready
- [ ] Test Docker containers
- [ ] Prepare backup code (in case of issues)

### Materials:
- [ ] Slide deck (if using)
- [ ] Demo environment ready
- [ ] Link to GitHub repository
- [ ] Zoom/Teams room open
- [ ] Recording started (if applicable)

---

## 📖 Detailed Session Plan

### **0:00-0:10 | Introduction (10 min)**

**Welcome & Icebreaker (3 min)**
- Welcome participants
- Brief intro: "Who you are, what you're working on"
- Poll: Experience level (beginner/intermediate/advanced)

**Workshop Overview (4 min)**
```
Today's Story: Game Arena Legends needs to modernize!

We have 3 legacy services:
1. Java Tournament Service (Spring Boot 2.7)
2. .NET Stats API (.NET Framework 4.8)
3. Angular Dashboard (Angular 12)

Your mission: Modernize all three + add DevOps automation
```

**Tools Verification (3 min)**
- Ask participants to run `./scripts/verify-setup`
- Help anyone with missing tools
- Show GitHub Copilot is working

---

### **0:10-0:40 | Exercise 1: Java (30 min)**

**Introduction (2 min)**
- Explain the Tournament Service
- Show current issues (blocking I/O, outdated dependencies)
- Target: Spring Boot 3.2 with reactive patterns

**Live Demo (10 min)**
1. Show legacy code structure
2. Use Copilot to analyze: `@workspace analyze this Spring Boot project`
3. Update `pom.xml` with Copilot
4. Convert one controller to reactive live
5. Run and test

**Guided Practice (15 min)**
- Participants follow along
- Work through exercise-1-java.md
- Circulate to help (if in-person)
- Monitor chat for questions (if virtual)

**Key Teaching Points:**
- ⚠️ Common mistake: Forgetting `javax` → `jakarta`
- 💡 Tip: Use `Mono<T>` for single items, `Flux<T>` for collections
- 🎯 Success criteria: Health check returns UP

**Checkpoint (3 min)**
- Quick poll: "Who got it working?"
- Share 1-2 common issues and solutions
- Show reference solution if needed

---

### **0:40-1:10 | Exercise 2: .NET (30 min)**

**Introduction (2 min)**
- Explain Player Stats API
- Show .NET Framework limitations
- Target: .NET 8 with minimal APIs

**Live Demo (10 min)**
1. Show legacy .NET Framework code
2. Create new .NET 8 project
3. Use Copilot to convert controller to minimal API
4. Show EF Core migration
5. Test endpoints with Swagger

**Guided Practice (15 min)**
- Participants modernize the .NET API
- Work through exercise-2-dotnet.md
- Emphasize minimal APIs pattern

**Key Teaching Points:**
- ⚠️ Common mistake: Trying to upgrade Framework in-place (can't do it!)
- 💡 Tip: Minimal APIs reduce boilerplate significantly
- 🎯 Success criteria: Swagger UI shows all endpoints

**Checkpoint (3 min)**
- Quick demo of working solution
- Address questions
- Transition to frontend

---

### **1:10-1:30 | Exercise 3: Angular (20 min)**

**Introduction (2 min)**
- Explain Tournament Dashboard
- Show Angular 12 limitations
- Target: Angular 18 with signals

**Live Demo (7 min)**
1. Run `ng update` to Angular 18
2. Convert NgModule to standalone
3. Show signals replacing RxJS
4. Demonstrate @if/@for syntax
5. Quick SSR demo

**Guided Practice (10 min)**
- Participants upgrade Angular app
- Work through exercise-3-angular.md
- Focus on standalone components and signals

**Key Teaching Points:**
- ⚠️ Common mistake: Missing imports in standalone components
- 💡 Tip: Signals are simpler than RxJS for most use cases
- 🎯 Success criteria: App runs with `ng serve`

**Checkpoint (1 min)**
- Quick thumbs up/down poll
- Jump to Exercise 4

---

### **1:30-1:50 | Exercise 4: DevOps (20 min)**

**Introduction (2 min)**
- Explain need for containers and CI/CD
- Show target architecture diagram
- Mention data pipeline component

**Live Demo (8 min)**
1. Show multi-stage Dockerfile for Java
2. Build and run container
3. Show GitHub Actions workflow
4. Quick data pipeline demo

**Guided Practice (8 min)**
- Participants containerize at least one service
- Create basic GitHub Actions workflow
- Optional: Run data pipeline

**Key Teaching Points:**
- ⚠️ Common mistake: Large Docker images (use multi-stage!)
- 💡 Tip: Use caching in GitHub Actions
- 🎯 Success criteria: Docker container runs successfully

**Checkpoint (2 min)**
- Demo docker-compose running all services
- Show successful GitHub Actions run

---

### **1:50-2:00 | Wrap-up (10 min)**

**Summary (3 min)**
- Recap what was accomplished
- Show before/after comparison
- Highlight key learnings

**Q&A (5 min)**
- Open floor for questions
- Share additional resources
- Discuss real-world applications

**Next Steps (2 min)**
- Share completion certificate
- Point to additional resources
- Encourage them to try on their own projects
- Ask for feedback survey

---

## 🎤 Facilitator Tips

### Keep Energy High
- ✅ Use enthusiastic tone
- ✅ Share personal anecdotes
- ✅ Celebrate small wins
- ✅ Keep pace moving

### Handle Questions
- ✅ Repeat questions for virtual audience
- ✅ "Great question! Let me show you..."
- ✅ Defer complex questions to end
- ✅ Admit when you don't know

### Deal with Issues
- ✅ Have backup code ready
- ✅ "That's a common issue, here's the fix..."
- ✅ Use breakout rooms for individual help
- ✅ Share troubleshooting doc

### Engagement Tactics
- ✅ Use polls throughout
- ✅ Ask participants to share screens
- ✅ Encourage chat interaction
- ✅ Celebrate first completions

---

## 🔧 Troubleshooting Guide

### Common Issues & Solutions

**Issue 1: GitHub Copilot Not Working**
```
Solution:
1. Check Copilot subscription status
2. Restart VS Code
3. Sign out and sign back in
4. Check status bar for Copilot icon
```

**Issue 2: Java Build Failures**
```
Solution:
1. Verify Java 17+ is installed
2. Clear Maven cache: rm -rf ~/.m2/repository
3. Run: mvn clean install -U
```

**Issue 3: .NET SDK Not Found**
```
Solution:
1. Install .NET 8 SDK
2. Add to PATH
3. Restart terminal
4. Verify: dotnet --version
```

**Issue 4: Docker Build Errors**
```
Solution:
1. Ensure Docker Desktop is running
2. Check Dockerfile syntax
3. Try: docker system prune -a
4. Use reference Dockerfiles from repo
```

**Issue 5: Participants Falling Behind**
```
Solution:
1. Pause and do collective checkpoint
2. Share working code for them to catch up
3. Offer office hours after workshop
4. Point to detailed README for later
```

---

## 📊 Assessment & Feedback

### During Workshop
- [ ] Monitor chat for confusion
- [ ] Watch participant screens (if possible)
- [ ] Do quick polls after each exercise
- [ ] Note common issues for future improvements

### Post-Workshop Survey
Send within 24 hours:
```
1. How would you rate the workshop? (1-5 stars)
2. Which exercise was most valuable?
3. What was most challenging?
4. What should we add/remove?
5. Would you recommend this to colleagues?
6. What topics would you like in future workshops?
```

---

## 📦 Materials Checklist

### Before Workshop:
- [ ] GitHub repository cloned and tested
- [ ] All exercises verified to work
- [ ] Setup scripts tested on multiple platforms
- [ ] Slide deck prepared (if using)
- [ ] Demo environment ready
- [ ] Backup code accessible

### During Workshop:
- [ ] Screen sharing tested
- [ ] GitHub Copilot working
- [ ] Chat/Q&A monitored
- [ ] Recording started (if applicable)
- [ ] Breakout rooms ready (if needed)

### After Workshop:
- [ ] Recording uploaded
- [ ] Certificates sent
- [ ] Feedback survey sent
- [ ] Follow-up resources shared
- [ ] Thank you emails sent

---

## 🌟 Success Metrics

### Quantitative:
- **Completion Rate:** Target 80%+ complete at least 2 exercises
- **Satisfaction Score:** Target 4.5+/5 stars
- **NPS Score:** Target 8+/10

### Qualitative:
- Participants can explain modernization benefits
- Participants use GitHub Copilot effectively
- Participants feel confident to try on own projects

---

## 📞 Support Contacts

**Technical Issues:**
- Email: workshop-support@example.com
- Slack: #game-arena-workshop

**GitHub Copilot Issues:**
- GitHub Support: support.github.com

---

## 🎓 Certification

After completion, send certificate:
```
This certifies that [Participant Name] has successfully completed the
"Game Arena Legends - App Modernization with GitHub Copilot" workshop
on [Date], demonstrating skills in Java, .NET, Angular modernization,
and DevOps automation.

Instructor: [Your Name]
Date: [Date]
```

---

## 📚 Additional Resources for Facilitators

### Internal Knowledge Base:
- Previous workshop recordings
- Common Q&A document
- Troubleshooting playbook

### External References:
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Spring Boot Migration Guide](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-3.0-Migration-Guide)
- [.NET Migration Guide](https://learn.microsoft.com/en-us/dotnet/core/porting/)
- [Angular Update Guide](https://update.angular.io/)

---

**Good luck with your workshop! You've got this! 🎉**

*For questions about this guide, contact: workshop-admin@example.com*
