import 'package:flutter/material.dart';

import 'responsive_layouts.dart';

class ResponsiveWid extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ResponsiveWid({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  // screen sizes
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= AppLayoutConst.kmovilwidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < AppLayoutConst.ktabletwidth &&
      MediaQuery.of(context).size.width > AppLayoutConst.kmovilwidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppLayoutConst.ktabletwidth;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width >= AppLayoutConst.ktabletwidth) {
      return desktop;
    } else if (width < AppLayoutConst.ktabletwidth &&
        width > AppLayoutConst.kmovilwidth) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
