import 'package:alumni_app/core/config/router/app_routes_pages.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';

class MedicosPage extends StatelessWidget {
  const MedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicos'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.medicos.pageName),
      ),
      body: const Center(
        child: Text('Welcome to Medicos'),
      ),
    );
  }
}
