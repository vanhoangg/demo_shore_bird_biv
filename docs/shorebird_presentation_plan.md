## Shorebird Demo & Presentation Plan

### App & Codebase Briefing
- Entry point `lib/main.dart` wires `MaterialApp` to `FinanceHomeV1`, establishing the baseline release screen while the patched `FinanceHomeV2` stays compiled in for future Shorebird updates.
- `FinanceHomeV1` vs `FinanceHomeV2` (`lib/finance_home_v1.dart`, `lib/finance_home_v2.dart`): both share the glassmorphic layout, but V2 introduces a depreciation field, richer gradients, and new copy—ideal for showing logic/UI patches without store redeploys.
- Theme system `lib/theme/finance_theme.dart` provides seasonal palettes and “patched” messaging strings; demonstrate how changing the `FinanceSeason` or labels highlights instant UX tweaks from patches.
- `shorebird.yaml` contains app_id `aa763937-47f4-4d3f-9df6-7e747f4a06ce`, and `pubspec.yaml` embeds it as an asset so the updater is ready out of the box.

### Demo Scenario Design
- Baseline store build shows `FinanceHomeV1` with `FinanceSeason.hot`, letting you stress that Revenue/Expense is all customers see pre-patch.
- Patch story: ship a Shorebird patch that swaps home to `FinanceHomeV2`, flips the season to `FinanceSeason.rain`, and adds depreciation math plus new copy—proving the same store binary becomes “advanced mode.”
- Workflow talking points:
  ```
  shorebird release ios --flutter-version <match-ci-version>
  shorebird release android --flutter-version <match-ci-version>
  # make UI + logic tweak (e.g., switch to FinanceHomeV2)
  shorebird patch ios --release-version 1.0.0+1
  shorebird patch android --release-version 1.0.0+1
  ```
  - Highlight how the CLI reads `app_id` from `shorebird.yaml`, produces tiny Dart AOT bundles, and skips store review cycles.
- Proof moments: live-swap between devices with/without connectivity, toggle airplane mode to explain caching, and show Shorebird updater logs confirming downloads.
- Operational safeguards: emphasize Shorebird console rollout percentages, staged disabling, and the requirement for full releases when native plugins or ABI bumps change.

### Presentation Outline & Talking Points
1. Opening problem  
   - “App store gatekeeping slows hotfixes” with metric(s) like average review delay.  
   - Visual: timeline comparing Shorebird patch vs store resubmission.
2. What is Shorebird?  
   - Architecture slide showing embedded updater SDK, managed patch CDN, CLI workflow, and the `app_id`.
3. Demo app setup  
   - Screenshots of `FinanceHomeV1` (Revenue/Expense) vs `FinanceHomeV2` (extra field, new badge) labeled with file paths to connect code and UX.
4. Integration steps  
   - Bullets: install Shorebird CLI, run `shorebird init`, commit `shorebird.yaml`, declare asset in `pubspec.yaml`, add updater to native builds (already in repo). Include snippet from `main.dart` proving no runtime change needed.
5. Live patch walkthrough  
   - Show production binary, reproduce “need depreciation now,” hot reload locally, run `shorebird patch`, relaunch release build to see `FinanceSeason.rain` UI. Mention `FinanceThemeData.versionLabelAdvanced` to call out patched messaging.
6. Observability & guardrails  
   - Mention patch size, download time, rollback speed, QA expectations, and staging usage.
7. Closing  
   - ROI slide (turnaround drops from days to minutes) and CTA for piloting Shorebird on non-critical surfaces first. Include contingency summary (offline fallback, forced store updates for native changes).

### Visual & Rehearsal Tips
- Capture high-res screenshots of both finance screens and make a split-view slide highlighting differences.
- Record CLI session ahead of time and keep a GIF on standby in case live terminal sharing fails.
- Practice the kill-switch story (`shorebird patch rollback`) to demonstrate safety.
- Prepare devices: one already patched, another freshly installed but offline, to show updater cache behavior.

### Metrics & Talking Points
- Patch bundle size vs full IPA/APK.  
- Time from code change to device (<2 minutes target).  
- Crash-free session rate or other KPIs improved by faster hotfixes.

### Contingency Checklist
- Run `shorebird doctor` before presenting; cache credentials locally to avoid MFA issues.  
- Reset app data if you need to re-demo downloads:
  ```
  adb shell pm clear com.example.demo_shore_bird
  xcrun simctl erase all
  ```
- Keep fallback slide deck screenshots/gifs ready if live mirroring flakes.

