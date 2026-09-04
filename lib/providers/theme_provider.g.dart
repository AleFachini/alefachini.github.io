// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeThemeHash() => r'3f924688e240550fb9ade5415f94759474272dd9';

/// Manages the active theme selection.
///
/// Holds the current theme key and exposes the corresponding [ThemeData].
/// To add a new theme, register it in [AppTheme.themes] and set the key here.
///
/// Copied from [ActiveTheme].
@ProviderFor(ActiveTheme)
final activeThemeProvider = NotifierProvider<ActiveTheme, String>.internal(
  ActiveTheme.new,
  name: r'activeThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveTheme = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
