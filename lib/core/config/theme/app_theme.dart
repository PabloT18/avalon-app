import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      colorSchemeSeed: AppColors.primaryBlueMaterial,
      fontFamily: 'Sora',
      // dividerColor: ThemeData().dividerColor,
      // expansionTipleTheme: const ExpansionTileThemeData()
      //     .copyWith(collapsedIconColor: AppColors.primaryBlue),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          color: AppColors.primaryBlue,
          // fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.bold,
        ),

        //   bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        //   bodyMedium: TextStyle(fontSize: 16),
        //   bodySmall: TextStyle(fontSize: 14),
        labelLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //   labelMedium: TextStyle(
        //     fontSize: 14,
        //     color: AppColors.primaryBlue,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   labelSmall: TextStyle(
        //     fontSize: 12,
        //     color: AppColors.primaryBlue,
        //     fontWeight: FontWeight.bold,
        //   ),
      ),
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        fillColor: Colors.white.withOpacity(0.3),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        helperStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sora',
        ),
        hintStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'Sora',
        ),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'Sora',
          fontWeight: FontWeight.bold,
        ),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Sora',
        ),
      ),
      // appBarTheme: const AppBarTheme(
      //     color: AppColors.primaryBlue,
      //     iconTheme: IconThemeData(color: Colors.white)),
      // fontFamily: 'Sora',
      // splashColor: AppColors.primaryBlue.withOpacity(0.05),
      // cardTheme: const CardTheme().copyWith(
      //   surfaceTintColor: Colors.white,
      // ),
      // tabBarTheme: const TabBarTheme(
      //   labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //   unselectedLabelStyle:
      //       TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      // ),
      // drawerTheme: const DrawerThemeData(
      //   surfaceTintColor: Colors.white,
      // ),
    );
  }
}
