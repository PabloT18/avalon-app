import 'dart:io';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UtilsFunctionsViews {
  static Future<void> showInfoStatesTypesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          apptexts.citasPage.estados,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoCerrado} (C)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoGestionando} (G)'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text('${apptexts.citasPage.estadoPorGestionar} (P)'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  static Color getColorByState(String state) {
    switch (state.toUpperCase()) {
      case 'CERRADO' || "C":
        return Colors.red;
      case 'GESTIONANDO' || "G":
        return Colors.blue;
      case 'POR GESTIONAR' || "P" || "N":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String getStateStrinByState(String state) {
    switch (state.toUpperCase()) {
      case 'CERRADO' || "C":
        return apptexts.citasPage.estadoCerrado;
      case 'GESTIONANDO' || "G":
        return apptexts.citasPage.estadoGestionando;
      case 'POR GESTIONAR' || "P" || "N":
        return apptexts.citasPage.estadoPorGestionar;
      default:
        return ' - ';
    }
  }

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

  // Función para iniciar la llamada
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'No se pudo iniciar la llamada al número $phoneNumber';
    }
  }

  // Función para abrir la aplicación de correo con un destinatario, asunto y cuerpo opcionales

// Función auxiliar para codificar los parámetros de la query
  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
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
        errorMaxLines: 5,
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon,
      );

  static Future<void> showFullScreenImage(File imageFile, context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pop(); // Cierra el diálogo al hacer tap en cualquier parte
            },
            child: InteractiveViewer(
              panEnabled: true, // Permite desplazar la imagen si está ampliada
              minScale: 0.5, // Escala mínima para el zoom
              maxScale: 4.0, // Escala máxima para el zoom
              child: Image.file(
                imageFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
