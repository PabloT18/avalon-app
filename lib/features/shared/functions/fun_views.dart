import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final route = parent + PAGES.welcome.pagePath;
    context.push(route, extra: url);
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

  /// TODO: ERROR: manage muti press OK
  // static Flushbar<dynamic> showFlushBar({
  //   required String mensajeError,
  //   bool isError = true,
  // }) {
  //   return Flushbar(
  //     message: mensajeError,
  //     duration: const Duration(seconds: 2),
  //     backgroundColor: Colors.black.withOpacity(0.5),
  //     barBlur: 10,
  //     margin: const EdgeInsets.all(AppLayoutConst.marginM)
  //         .copyWith(bottom: AppLayoutConst.marginL),
  //     borderRadius: BorderRadius.circular(8),

  //     leftBarIndicatorColor: isError ? Colors.red : AppColors.primaryBlue,
  //     // dismissDirection: ,
  //   );
  // }

  // }
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
