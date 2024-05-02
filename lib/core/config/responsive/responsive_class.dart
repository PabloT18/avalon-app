import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'responsive_layouts.dart';
export 'responsive_layouts.dart';

class ResponsiveCustom {
  late double _width, _height, _diagonal;
  late bool _portrait;
  late bool _movil;
  late bool _destokp;
  late bool _tablet;

  late double _paddingTop;
  late double _paddingBottom;

  late double _spaceAppBarFootBar;

  ResponsiveCustom._(BuildContext context) {
    Size size;
    size = MediaQuery.of(context).size;

    _height = size.height;
    _width = size.width;

    _diagonal = math.sqrt(math.pow(_height, 2) + math.pow(_width, 2));

    _portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _paddingTop = MediaQuery.of(context).padding.top;

    _movil = _width <= AppLayoutConst.kmovilwidth;
    _destokp = _width >= AppLayoutConst.ktabletwidth;
    _tablet = _width > AppLayoutConst.kmovilwidth &&
        _width < AppLayoutConst.ktabletwidth;
  }

  static ResponsiveCustom? _instance;

  static ResponsiveCustom of(BuildContext context) {
    if (kIsWeb) {
      return ResponsiveCustom._(context);
    } else {
      return _instance ??= ResponsiveCustom._(context);
    }
  }

  // static Responsive? _instance;

  // static Responsive instance(BuildContext context) =>
  //     _instance ??= Responsive._(context);

  double wp(double porcent) => _width * porcent / 100;
  double dp(double porcent) => _diagonal * porcent / 100;
  double hp(double porcent) => _height * porcent / 100;

  double hpa(double porcent, {bool home = true}) {
    final res = _height -
        _paddingTop -
        (home ? (_portrait ? 80 : 60) : 60) -
        (home ? 75 : 0);
    return res * porcent / 100;
  }

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  double get spaceAppbarFoobar => _spaceAppBarFootBar;

  double get paddingTop => _paddingTop;
  double get paddingBottom => _paddingBottom;

  bool get portrait => _portrait;

  bool get movil => _movil;
  bool get desktop => _destokp;
  bool get tablet => _tablet;

  static Widget x(double no) => SizedBox(width: no);
  static Widget y(double no) => SizedBox(height: no);
}
