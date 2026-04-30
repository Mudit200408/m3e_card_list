import 'package:flutter/services.dart';

/// Haptic feedback intensity levels for Material 3 Expressive components.
enum M3EHapticFeedback {
  /// No haptic feedback.
  none,

  /// Light haptic impact.
  light,

  /// Medium haptic impact.
  medium,

  /// Heavy haptic impact.
  heavy,
}

/// Helper function to apply haptic feedback based on [M3EHapticFeedback].
void applyHaptic(M3EHapticFeedback haptic) {
  switch (haptic) {
    case M3EHapticFeedback.light:
      HapticFeedback.lightImpact();
      break;
    case M3EHapticFeedback.medium:
      HapticFeedback.mediumImpact();
      break;
    case M3EHapticFeedback.heavy:
      HapticFeedback.heavyImpact();
      break;
    case M3EHapticFeedback.none:
      break;
  }
}

/// The position of a card within a list, used to determine its corner radii.
enum M3ECardPosition {
  /// The first item in a list with more than one item.
  first,

  /// An item between the first and last items.
  middle,

  /// The last item in a list with more than one item.
  last,

  /// The only item in a list.
  single,
}
