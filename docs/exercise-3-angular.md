# Exercise 3: Angular Tournament Dashboard Modernization 🎨

**Duration**: 20 minutes  
**Difficulty**: ⭐⭐ Intermediate  
**Prerequisites**: Node.js 20+, npm 10+, GitHub Copilot enabled

## 🎮 The Challenge

The **Tournament Dashboard** is the primary interface for tournament organizers and players. Built with **Angular 12** in 2021, it's missing modern features:

- 🐌 ChangeDetectionStrategy OnPush not used consistently
- 📦 NgModules everywhere (not standalone)
- 🔧 No signals for reactivity
- 🚫 Missing server-side rendering (SSR)
- ⚠️ Deprecated RxJS patterns

Your mission: **Upgrade to Angular 18 with standalone components, signals, and modern architecture.**

## 📋 What You'll Learn

- ✅ Upgrade Angular 12 → 18 using Angular CLI
- ✅ Convert NgModules to standalone components
- ✅ Implement signals for state management
- ✅ Add server-side rendering (SSR)
- ✅ Modernize routing and lazy loading
- ✅ Use GitHub Copilot for Angular migrations

## 🏗️ Architecture Overview

**Before (Legacy):**
```
Angular 12
├── NgModule-based architecture
├── Zone.js change detection
├── RxJS for all state
└── Client-side rendering only
```

**After (Modernized):**
```
Angular 18
├── Standalone components
├── Signals for reactivity
├── Zoneless change detection
└── Server-side rendering (SSR)
```

## 🚀 Step-by-Step Guide

### Step 1: Analyze Legacy Code (3 minutes)

1. Navigate to the legacy code:
```bash
cd legacy-code/angular-dashboard
```

2. Check Angular version:
```bash
cat package.json | grep "@angular/core"
# Should show: "^12.2.0"
```

3. **Use GitHub Copilot for analysis:**

Open Copilot Chat:
```
@workspace Analyze this Angular project and list deprecated patterns that need updating for Angular 18
```

Expected findings:
- [ ] NgModules should be converted to standalone
- [ ] RxJS BehaviorSubject can be replaced with signals
- [ ] RouterModule needs updating
- [ ] Missing SSR configuration

### Step 2: Upgrade Angular CLI (2 minutes)

1. **Update Angular CLI globally:**

```bash
npm install -g @angular/cli@18
ng version
```

2. **Run Angular Update:**

```bash
cd legacy-code/angular-dashboard
ng update @angular/core@18 @angular/cli@18 --force
```

This will automatically:
- Update all Angular packages to v18
- Migrate deprecated APIs
- Update angular.json configuration

### Step 3: Convert to Standalone Components (5 minutes)

**Use GitHub Copilot to automate conversion:**

1. Open `app.module.ts`
2. In Copilot Chat, ask:

```
Convert this Angular NgModule architecture to standalone components. Update app.module.ts to bootstrap a standalone component.
```

**Before (app.module.ts):**
```typescript
@NgModule({
  declarations: [
    AppComponent,
    TournamentListComponent,
    TournamentDetailComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    RouterModule.forRoot(routes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
```

**After (main.ts with standalone):**
```typescript
import { bootstrapApplication } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { AppComponent } from './app/app.component';
import { routes } from './app/app.routes';

bootstrapApplication(AppComponent, {
  providers: [
    provideRouter(routes),
    provideHttpClient()
  ]
}).catch(err => console.error(err));
```

**Update app.component.ts to standalone:**
```typescript
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  template: `
    <header class="header">
      <h1>🏆 Game Arena Legends</h1>
      <nav>
        <a routerLink="/tournaments">Tournaments</a>
        <a routerLink="/players">Players</a>
      </nav>
    </header>
    <main>
      <router-outlet></router-outlet>
    </main>
  `,
  styles: [`
    .header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 1rem 2rem;
    }
    nav a {
      margin: 0 1rem;
      color: white;
      text-decoration: none;
    }
  `]
})
export class AppComponent {
  title = 'Game Arena Dashboard';
}
```

### Step 4: Implement Signals for State (5 minutes)

Replace RxJS BehaviorSubject with Angular Signals:

**Before (Legacy Service with RxJS):**
```typescript
@Injectable({ providedIn: 'root' })
export class TournamentService {
  private tournamentsSubject = new BehaviorSubject<Tournament[]>([]);
  tournaments$ = this.tournamentsSubject.asObservable();

  loadTournaments(): void {
    this.http.get<Tournament[]>('/api/tournaments')
      .subscribe(data => this.tournamentsSubject.next(data));
  }
}
```

**After (Modern with Signals):**

Ask Copilot:
```
Convert this service to use Angular signals instead of RxJS BehaviorSubject
```

```typescript
import { Injectable, signal, computed } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { toSignal } from '@angular/core/rxjs-interop';

@Injectable({ providedIn: 'root' })
export class TournamentService {
  private http = inject(HttpClient);
  
  // Signal-based state
  tournaments = signal<Tournament[]>([]);
  
  // Computed values
  upcomingTournaments = computed(() => 
    this.tournaments().filter(t => t.status === 'UPCOMING')
  );
  
  activeTournaments = computed(() => 
    this.tournaments().filter(t => t.status === 'IN_PROGRESS')
  );

  async loadTournaments(): Promise<void> {
    const data = await firstValueFrom(
      this.http.get<Tournament[]>('/api/tournaments')
    );
    this.tournaments.set(data);
  }
  
  // Or use toSignal for reactive streams
  tournaments$ = toSignal(
    this.http.get<Tournament[]>('/api/tournaments'),
    { initialValue: [] }
  );
}
```

**Update component to use signals:**
```typescript
import { Component, inject, OnInit, signal, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TournamentService } from './services/tournament.service';

@Component({
  selector: 'app-tournament-list',
  standalone: true,
  imports: [CommonModule],
  template: `
    <div class="tournaments">
      <h2>Tournaments ({{ tournaments().length }})</h2>
      
      <div class="filters">
        <button (click)="filterStatus.set('ALL')">All</button>
        <button (click)="filterStatus.set('UPCOMING')">Upcoming</button>
        <button (click)="filterStatus.set('IN_PROGRESS')">Active</button>
      </div>

      <div class="tournament-grid">
        @for (tournament of filteredTournaments(); track tournament.id) {
          <div class="tournament-card">
            <h3>{{ tournament.name }}</h3>
            <p>{{ tournament.game }}</p>
            <span class="status">{{ tournament.status }}</span>
          </div>
        }
      </div>
    </div>
  `,
  styles: [`
    .tournaments { padding: 2rem; }
    .tournament-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 1rem;
    }
    .tournament-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 1rem;
      transition: transform 0.2s;
    }
    .tournament-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
  `]
})
export class TournamentListComponent implements OnInit {
  private tournamentService = inject(TournamentService);
  
  tournaments = this.tournamentService.tournaments;
  filterStatus = signal<string>('ALL');
  
  // Computed signal for filtered tournaments
  filteredTournaments = computed(() => {
    const filter = this.filterStatus();
    if (filter === 'ALL') return this.tournaments();
    return this.tournaments().filter(t => t.status === filter);
  });

  async ngOnInit(): Promise<void> {
    await this.tournamentService.loadTournaments();
  }
}
```

### Step 5: Add Server-Side Rendering (3 minutes)

Enable SSR for better performance and SEO:

```bash
ng add @angular/ssr
```

This automatically:
- Adds server configuration
- Updates angular.json
- Creates server.ts

**Build and run with SSR:**
```bash
npm run build:ssr
npm run serve:ssr
```

### Step 6: Modern Control Flow (@if, @for) (2 minutes)

Angular 18 introduces new template syntax:

**Before (Legacy):**
```html
<div *ngIf="tournaments$ | async as tournaments">
  <div *ngFor="let tournament of tournaments">
    {{ tournament.name }}
  </div>
</div>
```

**After (Modern):**
```html
@if (tournaments(); as tourns) {
  @for (tournament of tourns; track tournament.id) {
    <div>{{ tournament.name }}</div>
  }
} @else {
  <p>Loading tournaments...</p>
}
```

Use Copilot to auto-convert:
```
@workspace Replace all *ngIf and *ngFor with @if and @for syntax across the project
```

## ✅ Success Criteria

Your modernization is complete when:

- [ ] Angular 18 is running successfully
- [ ] All components are standalone
- [ ] Signals are used for state management
- [ ] @if and @for control flow is implemented
- [ ] SSR builds and runs without errors
- [ ] Application loads faster (<2s LCP)
- [ ] No NgModule imports remain

## 🎯 Validation Commands

```bash
# Check Angular version
ng version

# Build for production
ng build --configuration production

# Build with SSR
npm run build:ssr

# Run development server
ng serve

# Run with SSR
npm run serve:ssr

# Lint
ng lint

# Test
ng test
```

## 🐛 Troubleshooting

### Issue 1: Module not found after upgrade
**Solution**: Clear cache and reinstall
```bash
rm -rf node_modules package-lock.json
npm install
```

### Issue 2: SSR hydration errors
**Solution**: Ensure all components are SSR-compatible
```typescript
// Use isPlatformBrowser check
if (isPlatformBrowser(this.platformId)) {
  // Browser-only code
}
```

### Issue 3: Signals not updating
**Solution**: Use `.set()` or `.update()` methods
```typescript
// Correct
this.count.set(10);
this.count.update(val => val + 1);

// Incorrect (won't trigger updates)
this.count() = 10;
```

## 🎓 Key Takeaways

1. **Standalone components** reduce boilerplate and improve tree-shaking
2. **Signals** provide simpler reactive state than RxJS
3. **SSR** dramatically improves initial load performance
4. **Modern control flow** (@if/@for) is more intuitive
5. **GitHub Copilot** can automate most Angular migrations

## 📚 Additional Resources

- [Angular Update Guide](https://update.angular.io/)
- [Angular Signals Documentation](https://angular.io/guide/signals)
- [Standalone Components Guide](https://angular.io/guide/standalone-components)
- [Angular SSR Guide](https://angular.io/guide/ssr)

## 🚀 Next Steps

Fantastic! You've modernized the Angular dashboard. Now finish strong with:

**[Exercise 4: DevOps & Data Engineering →](exercise-4-devops-data.md)**

Or explore bonus challenges:
- Add NgRx for complex state management
- Implement Progressive Web App (PWA) features
- Add internationalization (i18n)
- Optimize bundle size with lazy loading

---

**🎨 Achievement Unlocked: Angular Modernization Wizard!**
