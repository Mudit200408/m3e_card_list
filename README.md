# M3E Card List

![M3E Card List Demo](screenshot.png)

A Flutter package providing expressive, Material 3 card lists with dynamically rounded corners inside normal `ListView`s and `CustomScrollView`s (via slivers). It also provides a lightweight `M3ECardColumn` for static layouts.

It automatically calculates and draws the corners to fit exactly the [Material 3 Expressive](https://m3.material.io/blog/building-with-m3-expressive) spec for adjacent items. It gives extensive customization options for developers including customizable splash ripples, custom border colors, custom elevation, and highly tunable haptic feedback.

## Features

- **Dynamic border radius:** The first and last items get a larger outer radius while adjoining cards receive a smaller inner radius seamlessly.
- **Sliver Support:** Provides `SliverM3ECardList` out of the box to beautifully tie into your complex `CustomScrollView`s and `SliverAppBar`s. 
- **Lightweight Alternative:** Use `M3ECardColumn` for static, non-interactive lists.
- **Individual Card Widget:** Use `M3ECard` directly for full control in custom layouts.
- **Highly Customizable:** Offers parameters for `gap`, `innerRadius`, `outerRadius`, `padding`, `splashColor`, `highlightColor`, and `splashFactory`.
- **Haptic Feedback:** Includes an easy API for `haptic` impact levels using the `M3EHapticFeedback` enum (none, light, medium, heavy) on tap.
- **Accessibility:** Built-in `semanticLabel`/`semanticLabelBuilder` support and `onFocusChange` callback.
- **Hover & Focus:** Custom `focusColor` and `hoverColor` for desktop/mouse interactions.
- **Empty State:** `emptyBuilder` parameter for all list components when `itemCount` is 0.

---

## 🎮 Interactive Demo

You can try out the package demo here: [m3e_core demo](https://mudit200408.github.io/m3e_core/)

---

## Breaking Changes (v0.0.1 → v0.1.0)

### 1. Haptic API changed from integer to enum

**Before (v0.0.1):**
```dart
M3ECardList(
  itemCount: 5,
  itemBuilder: (context, index) => Text('Item $index'),
  haptic: 3, // 0: None, 1: Light, 2: Medium, 3: Heavy
)
```

**After (v0.1.0):**
```dart
M3ECardList(
  itemCount: 5,
  itemBuilder: (context, index) => Text('Item $index'),
  haptic: M3EHapticFeedback.heavy, // none, light, medium, heavy
)
```

### 2. `margin` behavior changed (now wraps entire list)

**Before:** Each individual card applied the margin, causing gaps between cards.

**After:** The `margin` now wraps the entire list/group as a single outer padding.

### 3. `margin` parameter removed from `M3ECard`

`M3ECard(margin: ...)` no longer exists. Use `M3ECardList` or `M3ECardColumn` instead for `margin`.

### 4. Default `padding` changed

**Before:** `EdgeInsets.all(16.0)`

**After:** `EdgeInsets.all(12.0)` — tighter internal spacing in all cards.

### 5. `itemPadding` → `padding` (M3ECardColumn)

**Before:**
```dart
M3ECardColumn(
  itemPadding: EdgeInsets.all(12),
  children: [...],
)
```

**After:**
```dart
M3ECardColumn(
  padding: EdgeInsets.all(12),
  children: [...],
)
```

### 7. New `M3ECard` widget available

You can now use `M3ECard` directly for individual card rendering with full position control:

```dart
M3ECard(
  index: 0,
  position: M3ECardPosition.first,
  outerRadius: 24,
  innerRadius: 4,
  gap: 3,
  child: Text('Individual card'),
  onTap: (index) => print('Tapped'),
)
```

### 8. `M3ECardPosition` enum added

Used with `M3ECard` to specify card position: `first`, `middle`, `last`, `single`.

### 9. `calculateCardPosition` is now public

Previously private logic is now exported in `m3e_card_widget.dart`:

```dart
M3ECardPosition pos = calculateCardPosition(index, itemCount);
```

## Usage

Simply import the package and use `M3ECardList`, `SliverM3ECardList`, `M3ECardColumn`, or `M3ECard`.

```yaml
dependencies:
  m3e_card_list: ^0.1.0
```

```dart
import 'package:m3e_card_list/m3e_card_list.dart';

M3ECardList(
  itemCount: 5,
  itemBuilder: (context, index) {
      return Text('Data Item $index');
  },
  onTap: (index) {
      print('Tapped $index');
  },
  // Customize as needed:
  haptic: M3EHapticFeedback.medium,
  splashColor: Colors.teal.withValues(alpha: 0.2),
  highlightColor: Colors.teal.withValues(alpha: 0.1),
);
```

To entirely remove the ripple effect from a card list, use the `splashFactory: NoSplash.splashFactory` combined with transparent splash/highlight colors.

```dart
M3ECardList(
  itemCount: 2,
  itemBuilder: (context, index) => Text('No ripple here!'),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  onTap: (index) {},
)
```

## Static Column Example

If you don't need the performance overhead of a `ListView.builder` for small lists, you can use the lightweight `M3ECardColumn`. It is a simple wrapper for `Column` that supports all the same `InkWell` ripples, haptics, and customizations!

```dart
M3ECardColumn(
  children: [
    Text('Static Item 1'),
    Text('Static Item 2'),
    Text('Static Item 3'),
  ],
);
```

## Sliver Example

For use inside a `CustomScrollView`:

```dart
CustomScrollView(
  slivers: [
    SliverM3ECardList(
      itemCount: 10,
      itemBuilder: (context, index) => Text('Sliver Item $index'),
      onTap: (index) {},
    ),
  ],
)
```

## Additional information

Check out the `example` folder for a fully-featured showcase app demonstrating how to use both normal and sliver lists, along with dynamic theming.

## API Reference

### `M3ECard` — Individual Card Widget

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `index` | `int` | *required* | Item index (passed to callbacks) |
| `position` | `M3ECardPosition` | *required* | Card position: `first`, `middle`, `last`, `single` |
| `child` | `Widget` | *required* | Primary content of the card |
| `outerRadius` | `double` | *required* | Radius for outer corners |
| `innerRadius` | `double` | *required* | Radius for inner corners |
| `gap` | `double` | *required* | Vertical space below card (ignored for last/single) |
| `color` | `Color?` | `surfaceContainerHighest` | Background color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.all(12.0)` | Inner padding around child |
| `onTap` | `void Function(int index)?` | `null` | Tap callback |
| `onLongPress` | `void Function(int index)?` | `null` | Long-press callback |
| `semanticLabel` | `String?` | `null` | Accessibility label for screen readers |
| `mouseCursor` | `MouseCursor?` | auto (`click` if interactive) | Mouse cursor on hover |
| `focusColor` | `Color?` | `null` | Focus indicator color |
| `hoverColor` | `Color?` | `null` | Hover indicator color |
| `onFocusChange` | `void Function(bool)?` | `null` | Focus state change callback |
| `border` | `BorderSide?` | `BorderSide.none` | Border around the card |
| `elevation` | `double` | `0` | Card elevation |
| `splashColor` | `Color?` | `null` | Ink splash color |
| `highlightColor` | `Color?` | `null` | Ink highlight color |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `enableFeedback` | `bool` | `true` | Haptic/acoustic feedback on tap |
| `haptic` | `M3EHapticFeedback` | `M3EHapticFeedback.none` | Haptic level: `none`, `light`, `medium`, `heavy` |

> **Note:** `margin` is not available on `M3ECard`. Use `M3ECardList.margin` or `M3ECardColumn.margin` instead.

---

### `M3ECardList` — Standard & Lazy Lists

#### Common Parameters (both constructors)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `itemCount` | `int` | *required* | Number of items |
| `itemBuilder` | `IndexedWidgetBuilder` | *required* | Builds widget for each index |
| `outerRadius` | `double` | `24.0` | Radius for outer corners |
| `innerRadius` | `double` | `4.0` | Radius for inner corners |
| `gap` | `double` | `3.0` | Space between adjacent items |
| `color` | `Color?` | `surfaceContainerHighest` | Background color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.all(12.0)` | Inner padding for each card |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Outer margin around entire list |
| `onTap` | `void Function(int index)?` | `null` | Tap callback |
| `onLongPress` | `void Function(int index)?` | `null` | Long-press callback |
| `semanticLabelBuilder` | `String Function(int index)?` | `null` | Accessibility label builder |
| `mouseCursor` | `MouseCursor?` | auto (`click` if interactive) | Mouse cursor on hover |
| `focusColor` | `Color?` | `null` | Focus indicator color |
| `hoverColor` | `Color?` | `null` | Hover indicator color |
| `onFocusChange` | `void Function(int index, bool)?` | `null` | Focus state change callback |
| `border` | `BorderSide?` | `BorderSide.none` | Border around each card |
| `elevation` | `double` | `0` | Card elevation |
| `splashColor` | `Color?` | `null` | Ink splash color |
| `highlightColor` | `Color?` | `null` | Ink highlight color |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `enableFeedback` | `bool` | `true` | Haptic/acoustic feedback on tap |
| `hptic` | `M3EHapticFeedback` | `M3EHapticFeedback.none` | Hptic level |
| `emptyBuilder` | `Widget?` | `null` | Widget shown when `itemCount` is 0 |

#### `M3ECardList.builder` Additional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `controller` | `ScrollController?` | `null` | Scroll position control |
| `physics` | `ScrollPhysics?` | `null` | Scroll physics |
| `shrinkWrap` | `bool` | `false` | Size to children instead of viewport |
| `listPadding` | `EdgeInsetsGeometry?` | `null` | Padding around the scrollable list |
| `addAutomaticKeepAlives` | `bool` | `true` | Wrap in `AutomaticKeepAlive` |
| `addRepaintBoundaries` | `bool` | `true` | Wrap in `RepaintBoundary` |
| `addSemanticIndexes` | `bool` | `true` | Wrap in `IndexedSemantics` |

#### `M3ECardList.of` Factory (static children)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `children` | `List<Widget>` | *required* | Pre-built card contents |
| *(all common params inherited)* | | | |

---

### `M3ECardColumn` — Static Column

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `children` | `List<Widget>` | *required* | Pre-built card widgets |
| `outerRadius` | `double` | `24.0` | Radius for outer corners |
| `innerRadius` | `double` | `4.0` | Radius for inner corners |
| `gap` | `double` | `3.0` | Space between adjacent items |
| `color` | `Color?` | `surfaceContainerHighest` | Background color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.all(12.0)` | Inner padding for each card |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Outer margin around entire column |
| `onTap` | `void Function(int index)?` | `null` | Tap callback |
| `onLongPress` | `void Function(int index)?` | `null` | Long-press callback |
| `semanticLabelBuilder` | `String Function(int index)?` | `null` | Accessibility label builder |
| `mouseCursor` | `MouseCursor?` | auto (`click` if interactive) | Mouse cursor on hover |
| `focusColor` | `Color?` | `null` | Focus indicator color |
| `hoverColor` | `Color?` | `null` | Hover indicator color |
| `onFocusChange` | `void Function(int index, bool)?` | `null` | Focus state change callback |
| `border` | `BorderSide?` | `BorderSide.none` | Border around each card |
| `elevation` | `double` | `0` | Card elevation |
| `splashColor` | `Color?` | `null` | Ink splash color |
| `highlightColor` | `Color?` | `null` | Ink highlight color |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `enableFeedback` | `bool` | `true` | Haptic/acoustic feedback on tap |
| `haptic` | `M3EHapticFeedback` | `M3EHapticFeedback.none` | Haptic level |
| `emptyBuilder` | `Widget?` | `null` | Widget shown when children is empty |

---

### `SliverM3ECardList` — Sliver List

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `itemCount` | `int` | *required* | Number of items |
| `itemBuilder` | `IndexedWidgetBuilder` | *required* | Builds widget for each index |
| `outerRadius` | `double` | `24.0` | Radius for outer corners |
| `innerRadius` | `double` | `4.0` | Radius for inner corners |
| `gap` | `double` | `3.0` | Space between adjacent items |
| `color` | `Color?` | `surfaceContainerHighest` | Background color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.all(12.0)` | Inner padding for each card |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Outer margin (wraps in `SliverPadding`) |
| `onTap` | `void Function(int index)?` | `null` | Tap callback |
| `onLongPress` | `void Function(int index)?` | `null` | Long-press callback |
| `semanticLabelBuilder` | `String Function(int index)?` | `null` | Accessibility label builder |
| `mouseCursor` | `MouseCursor?` | auto (`click` if interactive) | Mouse cursor on hover |
| `focusColor` | `Color?` | `null` | Focus indicator color |
| `hoverColor` | `Color?` | `null` | Hover indicator color |
| `onFocusChange` | `void Function(int index, bool)?` | `null` | Focus state change callback |
| `border` | `BorderSide?` | `BorderSide.none` | Border around each card |
| `elevation` | `double` | `0` | Card elevation |
| `splashColor` | `Color?` | `null` | Ink splash color |
| `highlightColor` | `Color?` | `null` | Ink highlight color |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Custom splash factory |
| `enableFeedback` | `bool` | `true` | Haptic/acoustic feedback on tap |
| `haptic` | `M3EHapticFeedback` | `M3EHapticFeedback.none` | Haptic level |
| `emptyBuilder` | `Widget?` | `null` | Widget shown when `itemCount` is 0 |
| `addAutomaticKeepAlives` | `bool` | `true` | Wrap in `AutomaticKeepAlive` |
| `addRepaintBoundaries` | `bool` | `true` | Wrap in `RepaintBoundary` |
| `addSemanticIndexes` | `bool` | `true` | Wrap in `IndexedSemantics` |

---

### Helper Functions & Enums

| Name | Type | Description |
|------|------|-------------|
| `M3EHapticFeedback` | `enum` | Haptic levels: `none`, `light`, `medium`, `heavy` |
| `M3ECardPosition` | `enum` | Card positions: `first`, `middle`, `last`, `single` |
| `calculateCardPosition(index, total)` | `M3ECardPosition Function(int, int)` | Calculates position from index and total |
| `applyHaptic(M3EHapticFeedback)` | `void Function(...)` | Triggers haptic feedback |


## Radhe Radhe