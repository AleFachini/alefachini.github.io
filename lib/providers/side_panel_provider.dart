import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'side_panel_provider.g.dart';

/// Controls the visibility of the side navigation panel.
///
/// The panel becomes visible when the user hovers over the left edge
/// of the viewport, and hides when the mouse leaves the panel area.
@riverpod
class SidePanelVisible extends _$SidePanelVisible {
  @override
  bool build() => false;

  void show() => state = true;
  void hide() => state = false;
  void toggle() => state = !state;
}
