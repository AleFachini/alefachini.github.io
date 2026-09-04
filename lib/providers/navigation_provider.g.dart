// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeSectionHash() => r'edc439e5f57b6537f3e30c2417ef756e386c3b03';

/// Tracks the currently active (visible) section in the viewport.
///
/// Updated by the [HomePage] scroll listener to reflect which section
/// is currently most visible. The [SideNavigationPanel] watches this
/// to highlight the active nav item.
///
/// Copied from [ActiveSection].
@ProviderFor(ActiveSection)
final activeSectionProvider =
    AutoDisposeNotifierProvider<ActiveSection, PortfolioSection>.internal(
      ActiveSection.new,
      name: r'activeSectionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activeSectionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ActiveSection = AutoDisposeNotifier<PortfolioSection>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
