# Tooltip Tutorial Feature - Shorebird Demonstration

## Overview

This feature demonstrates Shorebird's powerful patching capabilities through an interactive tutorial system. Users see guided tooltips when they first use the app or after updates, showcasing how Shorebird can update tutorial content, reset user states, and modify app behavior without requiring app store updates.

## Key Features

### 1. **Version-Based Reset Mechanism**
- Tooltips are tracked per version using `TooltipService`
- When `currentTooltipVersion` changes in a Shorebird patch, all tooltips reset automatically
- Users see updated tutorials without reinstalling the app

### 2. **Localized Tutorial Content**
- All tooltip messages are stored in code-based localization (patchable!)
- Supports English, Spanish, French, and Vietnamese
- Tutorial content can be updated via patches in any language

### 3. **Sequential Tooltip Flow**
- Tooltips appear one at a time in a logical sequence
- Users can dismiss each tooltip individually
- Progress is saved per tooltip ID

### 4. **Beautiful UI/UX**
- Animated tooltips with fade and scale effects
- Highlight overlays to focus user attention
- Backdrop dimming for better visibility
- Arrow indicators pointing to target elements

## How It Demonstrates Shorebird

### Scenario 1: Updating Tutorial Content
**Before Patch:**
- Tooltip says: "Enter your total revenue here..."

**After Shorebird Patch:**
- Change the tooltip message in `app_localizations.dart`
- Deploy patch via `shorebird patch`
- Users see new content immediately without app update

### Scenario 2: Resetting Tutorial State
**Before Patch:**
- User has seen all tooltips
- `currentTooltipVersion = '1.0.0'`

**After Shorebird Patch:**
- Change `currentTooltipVersion = '1.0.1'` in `TooltipService`
- Deploy patch
- All users see tooltips again (great for new features!)

### Scenario 3: Adding New Tooltips
**Before Patch:**
- 5 tooltips exist

**After Shorebird Patch:**
- Add new tooltip IDs and messages
- Add new `TooltipConfig` entries
- Users see new tooltips in sequence

### Scenario 4: Changing Tutorial Flow
**Before Patch:**
- Tooltips show in order: revenue → expense → depreciation → calculate → profit

**After Shorebird Patch:**
- Reorder tooltips
- Remove or add steps
- Change tooltip positions (top/bottom/left/right)
- All changes apply instantly via patch

## Implementation Details

### Files Created

1. **`lib/finance/shared/services/tooltip_service.dart`**
   - Manages tooltip state persistence
   - Handles version-based resets
   - Uses SharedPreferences for storage

2. **`lib/finance/shared/widgets/guided_tooltip.dart`**
   - Reusable tooltip widget component
   - Handles animations and positioning
   - Supports multiple positions (top/bottom/left/right)

3. **`lib/finance/shared/widgets/tooltip_overlay_manager.dart`**
   - Manages tooltip sequence
   - Handles overlay lifecycle
   - Coordinates multiple tooltips

4. **`lib/finance/shared/widgets/tooltip_manager.dart`**
   - Alternative implementation (simpler approach)
   - Can be used for different use cases

### Localization Strings Added

All languages now include:
- `tooltipWelcomeTitle`
- `tooltipWelcomeMessage`
- `tooltipRevenueField`
- `tooltipExpenseField`
- `tooltipDepreciationField`
- `tooltipCalculateButton`
- `tooltipProfitDisplay`
- `tooltipGotIt`

## Usage Example

```dart
// In your screen widget
final GlobalKey _revenueKey = GlobalKey();
final GlobalKey _expenseKey = GlobalKey();

// In initState or after first frame
TooltipOverlayManager.showTooltips(
  context: context,
  theme: theme,
  strings: strings,
  tooltips: [
    TooltipConfig(
      id: 'revenue',
      targetKey: _revenueKey,
      position: TooltipPosition.bottom,
    ),
    TooltipConfig(
      id: 'expense',
      targetKey: _expenseKey,
      position: TooltipPosition.bottom,
    ),
  ],
);

// Attach keys to widgets
NumberInputField(
  fieldKey: _revenueKey,
  // ... other properties
)
```

## Shorebird Patch Workflow

### To Update Tutorial Content:

1. **Edit localization strings** in `lib/l10n/app_localizations.dart`
2. **Run:** `shorebird patch`
3. **Deploy:** Patch is live immediately

### To Reset All Tooltips:

1. **Change version** in `TooltipService.currentTooltipVersion`
2. **Run:** `shorebird patch`
3. **Result:** All users see tooltips again

### To Add New Tooltips:

1. **Add new strings** to localization classes
2. **Add new TooltipConfig** entries
3. **Run:** `shorebird patch`
4. **Result:** New tooltips appear in sequence

## Benefits for Shorebird Demo

1. **Immediate Updates**: Tutorial content updates instantly
2. **No App Store**: Changes deploy without app store approval
3. **User Experience**: Can reset tutorials for new features
4. **Localization**: Update translations without rebuilding
5. **A/B Testing**: Easy to test different tutorial flows
6. **Bug Fixes**: Fix tutorial typos/content instantly

## Testing

### Reset Tooltips for Testing:
```dart
await TooltipService.resetTooltip('revenue');
```

### Check Tooltip State:
```dart
final hasSeen = await TooltipService.hasSeenTooltip('revenue');
```

### Get Current Version:
```dart
final version = TooltipService.getTooltipVersion();
```

## Future Enhancements

- [ ] Add tooltip skip button
- [ ] Add tooltip progress indicator
- [ ] Support tooltip videos/images
- [ ] Add analytics tracking
- [ ] Support conditional tooltips based on user actions
- [ ] Add tooltip themes/variations
