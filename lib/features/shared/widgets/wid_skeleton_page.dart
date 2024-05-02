import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/material.dart';

class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key, required this.panelWidget});

  final Widget panelWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo estático
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.backgorund),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Página actual encima del fondo
        panelWidget,
      ],
    );
  }
}
