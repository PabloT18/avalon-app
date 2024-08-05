import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';

class FormasPagoPage extends StatelessWidget {
  const FormasPagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formaspago'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.formasPago.pageName),
      ),
      body: const Center(
        child: Text('Welcome to Formaspago'),
      ),
    );
  }
}
