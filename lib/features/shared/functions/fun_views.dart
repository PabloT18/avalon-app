import 'package:alumni_app/core/config/responsive/responsive_layouts.dart';

import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class UtilsFunctionsViews {
  static Future<void> openInWebview(BuildContext context, String url,
      {String parent = ''}) async {
    // final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return WebViewPage(
    //         url: url,
    //       );
    //     },
    //   ),
    // );\
    // final route = parent + PAGES.welcome.pagePath;
    // context.push(route, extra: url);
    // MaterialPageRoute(
    //   builder: (context) {
    //     return WebViewPage(
    //       url: url,
    //     );
    //   },
    // ),
    // )
    // ;

    // context.go(PAGES.webPage.pagePath, extra: url);
  }

  static Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static Flushbar<dynamic> showFlushBar({
    required String message,
    bool isError = true,
    double positionOffset = 0.0,
  }) {
    return Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.5),
      positionOffset: positionOffset,
      barBlur: 10,
      margin: const EdgeInsets.all(AppLayoutConst.marginM)
          .copyWith(bottom: AppLayoutConst.marginL),
      borderRadius: BorderRadius.circular(8),
      leftBarIndicatorColor: isError ? Colors.red : AppColors.primaryBlue,
    );
  }

  static void showUpdateDialog({
    required BuildContext context,
    required String currentVersion,
    String updateButtonText = 'Actualizar',
    String dismissButtonText = 'Mas tarde',
    required VoidCallback dismissAction,
  }) async {
    // await showDialog(
    // context: context,
    // barrierDismissible: true,
    // builder: (BuildContext context) {
    //     return AlertDialogUpdate(

    //       currentVersion: currentVersion,
    //       // forceUpdate: forceUpdate,
    //       // updateversion: updateversion,
    //       // dialogTitle: dialogTitle,
    //       // contentText: dialogText, // Contenido del Dialog
    //       // urlAndroid: urlAndroid,
    //       // urlIOs: urlIOs,
    //       updateButtonText: updateButtonText,
    //       dismissButtonText: dismissButtonText,
    //     );
    //   }).then((value) {
    // dismissAction();
    // });
  }

  static InputDecoration buildInputDecoration(
          {String? label,
          String? hint,
          IconData? icon,
          String? error,
          Widget? suffixIcon}) =>
      InputDecoration(
        helperStyle: const TextStyle(
          fontSize: 4,
          fontWeight: FontWeight.bold,
        ),
        errorText: error,
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon,
      );
}
