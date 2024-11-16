import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatUtils {
  PlatUtils._();

  /// Whether the operating system is a version of
  /// [ohos](https://en.wikipedia.org/wiki/OpenHarmony).
  static bool get isOhos => Platform.operatingSystem == 'ohos';

  /// Whether the operating system is a version of
  /// [Linux](https://en.wikipedia.org/wiki/Linux).
  ///
  /// This value is `false` if the operating system is a specialized
  /// version of Linux that identifies itself by a different name,
  /// for example Android (see [isAndroid]).
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Whether the operating system is a version of
  /// [macOS](https://en.wikipedia.org/wiki/MacOS).
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  /// Whether the operating system is a version of
  /// [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Whether the operating system is a version of
  /// [Android](https://en.wikipedia.org/wiki/Android_%28operating_system%29).
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Whether the operating system is a version of
  /// [iOS](https://en.wikipedia.org/wiki/IOS).
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Whether the operating system is a version of
  /// [Fuchsia](https://en.wikipedia.org/wiki/Google_Fuchsia).
  static bool get isFuchsia => defaultTargetPlatform == TargetPlatform.fuchsia;

  static bool get isMobile => isAndroid || isIOS || isOhos;

  static bool get isDesktop => isWindows || isMacOS || isLinux;
}
