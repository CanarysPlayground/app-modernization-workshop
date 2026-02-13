# Tournament Dashboard (Legacy)

## 🚨 LEGACY CODE - ANGULAR 12

This is the **legacy version** of the Tournament Dashboard built with:
- ❌ Angular 12 (outdated)
- ❌ NgModule architecture (needs standalone)
- ❌ RxJS BehaviorSubject for state (should use signals)
- ❌ No SSR (slow initial load)
- ❌ Old control flow syntax (*ngIf, *ngFor)

## Known Issues

1. **Performance**: Zone.js overhead for change detection
2. **Bundle Size**: Large due to NgModules
3. **Developer Experience**: Too much boilerplate
4. **SEO**: Client-side only rendering
5. **State Management**: Complex RxJS patterns

## Quick Start

```bash
# Install dependencies
npm install

# Run development server (requires Angular 12)
npm start

# Build
npm run build
```

## Your Mission

Follow [Exercise 3](../../docs/exercise-3-angular.md) to modernize this dashboard to Angular 18!

## Features

- Tournament listing with filters
- Player leaderboard
- Real-time match updates
- Tournament details and brackets

---

**Ready to upgrade to Angular 18? Head to [Exercise 3](../../docs/exercise-3-angular.md)! 🎨**
