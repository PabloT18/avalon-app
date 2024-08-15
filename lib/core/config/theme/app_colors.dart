import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';

class AppColors {
  // static const MaterialColor primaryBlueMaterial = MaterialColor(
  //   _primaryBlueValue,
  //   <int, Color>{
  //     50: Color(0x00023e7d),
  //     100: Color(0x00023e7d),
  //     200: Color(0x00023e7d),
  //     300: Color(0x00023e7d),
  //     400: Color(0x00023e7d),
  //     500: Color(_primaryBlueValue),
  //     600: Color(0x00023e7d),
  //     700: Color(0x00023e7d),
  //     800: Color(0x00023e7d),
  //     900: Color(0x00023e7d),
  //   },
  // );

  static const MaterialColor primaryBlueMaterial = MaterialColor(
    _primaryBlueValue,
    <int, Color>{
      50: Color(0xFF4A90E2), // Mucho más claro que el base
      100: Color(0xFF3E7DCB), // Más claro
      200: Color(0xFF346AB3), // Ligeramente más claro
      300: Color(0xFF2A579C), // Un poco más claro
      400: Color(0xFF204584), // Ligeramente más oscuro que el base
      500: Color(_primaryBlueValue), // Valor del color base (0x0023e7d)
      600: Color(0xFF19337D), // Más oscuro
      700: Color(0xFF162E70), // Aún más oscuro
      800: Color(0xFF132964), // Oscuro
      900: Color(0xFF0F2457), // Muy oscuro
    },
  );
  // static const _primaryBlueValue = 0xff1e367c;
  static const _primaryBlueValue = 0x00023D7D;

  // static const primaryBlue = Color(0xff1e367c);
  static const primaryBlue = Color(0xFF023e7d);
  static const cardBlue = Color(0xFF01203D); // Color de fondo de la tarjeta
  static const secondaryBlue = Color(0xFF6B8DC8);
  static const threeBlue = Color(0xFFBCD8F2);

  static const grey = Color(0xFFe5e5e5);
  static const white = Color(0xFFf9fbfe);

  static const colorsHorario = [
    Color(0xffFFB6C1),
    Color(0xff9CEEEF),
    Color(0xffF9F0A0),
    Color(0xff9ACD32),
    Color(0xffF8A7F8),
    Color(0xffFFD2AF),
    Color(0xffB0C4DE),
    Color(0xff7CFC00),
    Color(0xffE6E6FA),
    Color(0xff7FFFD4),
    Color(0xff00BFFF),
    Color(0xffFF7F50),
    Color(0xffD8BFD8),
    Color(0xffFFA500),
    Color(0xff00FFFF),
    Color(0xffFFA07A),
    Color(0xffFF69B4),
    Color(0xffFF8C00),
    Color(0xffFFFF00),
    Color(0xff00FA9A),
    Color(0xff1E90FF),
  ];

  static const blueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
  );

  static const grayBack = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0XFF2E2D36), Color(0XFF11101D)],
  );
  static const grayWhite = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF3F2FF)],
  );

  static const buttonGradi = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0XFF7DE7EB), Color(0XFF33BBCF)],
  );

  static const contactGradi = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0XFF2E2D36), Color(0XFF11101D)],
  );

  static BoxShadow primaryColorShadow = BoxShadow(
    color: AppColors.primaryBlue.withAlpha(100),
    blurRadius: 10.0,
    offset: const Offset(3, 5),
  );
  static BoxShadow blackColorShadow = BoxShadow(
    color: Colors.black.withAlpha(100),
    blurRadius: 12.0,
    offset: const Offset(0.0, 0.0),
  );
}
