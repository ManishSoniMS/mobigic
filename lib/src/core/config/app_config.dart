import 'package:flutter/material.dart';

abstract class AppConfig {
  AppConfig._();

  // static final GlobalKey<NavigatorState> navKey =
  //     GlobalKey<NavigatorState>();
  //
  //
  // static final GlobalKey<NavigatorState> shallNavKey = GlobalKey<NavigatorState>();

  /// A global key to get top most context
  ///
  /// used in [navigator] and [localization] shortcuts
  static final GlobalKey appKey = GlobalKey();
}

/// To get the currently active [ThemeData]
ThemeData get theme => Theme.of(AppConfig.appKey.currentContext!);

/// To get the currently active [TextTheme] from [ThemeData]
TextTheme get textTheme => theme.textTheme;

// NavigatorState get navigator => AppConfig.navKey.currentState!;

// /// [BeamerDelegate] of the currently active app
// ///
// /// Use this navigator to navigate in the app.
// BeamerDelegate get navigator => RouteManager.instance.delegate;

/// [ScaffoldMessenger] of the currently active app
///
/// Use this to show [SnackBar] or [MaterialBanner] in the app.
ScaffoldMessengerState get messenger =>
    ScaffoldMessenger.of(AppConfig.appKey.currentContext!);
