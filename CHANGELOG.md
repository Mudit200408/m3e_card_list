## 0.1.0

### Breaking Changes

* **Haptic API changed:** Integer `haptic: 3` replaced with `M3EHapticFeedback` enum (`none`, `light`, `medium`, `heavy`).
* **Color opacity API:** `withOpacity()` replaced with `withValues(alpha:)`.
* **Margin behavior changed:** `margin` now wraps the entire list/group instead of each individual card. This fixes visual gaps between cards.
* **`margin` removed from `M3ECard`:** Use `M3ECardList.margin` or `M3ECardColumn.margin` instead.
* **Default padding changed:** `EdgeInsets.all(16.0)` → `EdgeInsets.all(12.0)` for tighter internal spacing.
* **`M3ECardColumn` parameter renamed:** `itemPadding` → `padding`.
* **`RepaintBoundary` removed:** `M3ECard` no longer wraps in `RepaintBoundary` for lower GPU memory usage.
* **New `M3ECard` widget:** Individual card widget with `index`, `position` (`M3ECardPosition`), `outerRadius`, `innerRadius`, `gap` parameters.
* **`M3ECardPosition` enum added:** `first`, `middle`, `last`, `single` for use with `M3ECard`.
* **`calculateCardPosition` is now public:** Exported from `m3e_card_widget.dart`.

### New Features

* **`onLongPress` callback:** Added to `M3ECard`, `M3ECardList`, `SliverM3ECardList`, and `M3ECardColumn`.
* **Accessibility:** `semanticLabel` (M3ECard) and `semanticLabelBuilder` (lists) for screen reader support.
* **`mouseCursor`:** Custom mouse cursor support, defaults to `click` when interactive.
* **`focusColor` / `hoverColor`:** Custom focus and hover indicators for desktop/mouse interactions.
* **`onFocusChange` callback:** Notified when focus state changes.
* **`emptyBuilder`:** Shown when `itemCount` is 0 for all three list components.
* **`addAutomaticKeepAlives`:** Parity with Flutter's `ListView.builder`.
* **`addRepaintBoundaries`:** Parity with Flutter's `ListView.builder`.
* **`addSemanticIndexes`:** Parity with Flutter's `ListView.builder`.

### Behavioral Changes (Non-Breaking)

* **Margin no longer compounds:** Previously each card got the same margin causing gaps; now margin only surrounds the whole group.
* **Sliver list is always lazy:** `SliverM3ECardList` has no non-lazy variant by design.

## 0.0.1

* Initial release.
* Adds `M3ECardList` for standard ListViews.
* Adds `SliverM3ECardList` for CustomScrollViews.
* Adds `M3ECardColumn`, a lightweight rendering alternative for static card lists.
* Supports customizable corners, colors, borders, haptics, margin, and custom ink splashes following Material 3 Expressive guidelines.
