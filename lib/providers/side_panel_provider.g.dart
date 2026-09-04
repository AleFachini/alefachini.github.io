// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side_panel_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sidePanelVisibleHash() => r'21d0a8cfd381f3637cfea2bc62e8260e40917428';

/// Controls the visibility of the side navigation panel.
///
/// The panel becomes visible when the user hovers over the left edge
/// of the viewport, and hides when the mouse leaves the panel area.
///
/// Copied from [SidePanelVisible].
@ProviderFor(SidePanelVisible)
final sidePanelVisibleProvider =
    AutoDisposeNotifierProvider<SidePanelVisible, bool>.internal(
      SidePanelVisible.new,
      name: r'sidePanelVisibleProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sidePanelVisibleHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SidePanelVisible = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
