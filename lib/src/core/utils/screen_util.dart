import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_wrap_architecture/src/core/extension/extensions.dart';
import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class ScreenUtil {
  ScreenUtil._();

  /// Get current screen logical size representation
  ///
  /// extra small - ~320..599 dp, 4 column (phone)
  /// small - 600..1023 dp, 8 column (tablet)
  /// medium - 1024..1439 dp, 12 column (large tablet)
  ///
  /// [Breakpoints](https://material.io/design/layout/responsive-layout-grid.html#breakpoints)
  ///
  // static ScreenSize screenSize() {
  //   final window = ui.window;
  //   final size = window.physicalSize ~/ window.devicePixelRatio;
  //   return _screenSizeFromSize(size);
  // }

  static ScreenSize screenSizeOf(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(size);
    return _screenSizeFromSize(
      orientation().whenByValue(
        portrait: size,
        landscape: Size(size.height, size.width),
      ),
    );
  }

  static ScreenSize _screenSizeFromSize(Size size) {
    if (size.width <= ScreenSize.smallPhone.max) {
      return ScreenSize.smallPhone;
    }
    //  else if (size.width <= ScreenSize.phone.max) {
    //   return ScreenSize.phone;
    // } else if (size.width <= ScreenSize.tablet.max) {
    //   return ScreenSize.tablet;
    // } else if (size.width <= ScreenSize.largeTablet.max) {
    //   return ScreenSize.largeTablet;
    // }
    else {
      return ScreenSize.phone;
    }
  }

  /// Расположение экрана
  ///
  /// portrait - портретное
  /// landscape - альбомное
  ///
  static Orientation orientation() {
    final size = ui.window.physicalSize;
    return size.height > size.width
        ? Orientation.portrait
        : Orientation.landscape;
  }
}

@immutable
class ScreenSize {
  final num min;
  final num max;
  final String representation;

  @literal
  const ScreenSize._(
    this.representation,
    this.min,
    this.max,
  );

  static const ScreenSize smallPhone = ScreenSize._('tiny', 0, 379);
  static const ScreenSize phone = ScreenSize._('xsmall', 380, 599);
  static const ScreenSize tablet = ScreenSize._('small', 600, 1023);
  static const ScreenSize largeTablet = ScreenSize._('medium', 1024, 1439);

  @override
  String toString() => '<ScreenSize $representation $min..$max>';

  // ignore: long-parameter-list
  ScreenSizeWhenResult when<ScreenSizeWhenResult extends Object?>({
    ScreenSizeWhenResult Function()? smallPhone,
    required ScreenSizeWhenResult Function() phone,
    // required ScreenSizeWhenResult Function() tablet,
    // required ScreenSizeWhenResult Function() largeTablet,
  }) {
    switch (representation) {
      case 'tiny':
        return smallPhone?.call() ?? phone();
      case 'xsmall':
        return phone();
      // case 'small':
      //   return tablet();
      // case 'medium':
      //   return largeTablet();
      default:
        return phone();
    }
  }

  /// The [maybeWhen] method is equivalent to [when],
  /// but doesn't require all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra [orElse] required parameter,
  /// for fallback behavior.
  ///
  //ignore: long-parameter-list
  ScreenSizeWhenResult maybeWhen<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() orElse,
    ScreenSizeWhenResult Function()? smallPhone,
    ScreenSizeWhenResult Function()? phone,
    ScreenSizeWhenResult Function()? tablet,
    ScreenSizeWhenResult Function()? largeTablet,
  }) =>
      when<ScreenSizeWhenResult>(
        smallPhone: smallPhone ?? phone ?? orElse,
        phone: phone ?? orElse,
        // tablet: tablet ?? orElse,
        // largeTablet: largeTablet ?? orElse,
      );

  T whenByValue<T extends Object?>({
    T? smallPhone,
    required T phone,
    // required T tablet,
    // required T largeTablet,
  }) {
    switch (representation) {
      case 'tiny':
        return smallPhone ?? phone;
      case 'xsmall':
        return phone;
      // case 'small':
      //   return tablet;
      // case 'medium':
      //   return largeTablet;
      default:
        return phone;
    }
  }

  T maybeWhenByValue<T extends Object?>({
    required T orElse,
    T? smallPhone,
    T? phone,
    // T? tablet,
    // T? largeTablet,
  }) =>
      whenByValue<T>(
        smallPhone: smallPhone ?? phone ?? orElse,
        phone: phone ?? orElse,
        // tablet: tablet ?? orElse,
        // largeTablet: largeTablet ?? orElse,
      );

  @override
  int get hashCode => representation.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ScreenSize && representation == other.representation);
}
