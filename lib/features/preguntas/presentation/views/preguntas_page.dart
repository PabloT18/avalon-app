import 'package:alumni_app/core/config/router/app_routes_pages.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';

class PreguntasPage extends StatelessWidget {
  const PreguntasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.preguntas.pageName),
      ),
      body: const Center(
        child: Text('Welcome to Preguntas'),
      ),
    );
  }
}
