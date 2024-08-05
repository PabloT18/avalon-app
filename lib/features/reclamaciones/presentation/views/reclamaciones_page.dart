import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/wid_drawer.dart';

class ReclamacionesPage extends StatelessWidget {
  const ReclamacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclamaciones Page'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.formasPago.pageName),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Pagina en desarollo'),
          ),
        ],
      ),
    );
  }
}
