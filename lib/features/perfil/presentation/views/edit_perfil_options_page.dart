import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

class EditPerfilOptionsPage extends StatelessWidget {
  const EditPerfilOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.perfilPage.editProfile),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(apptexts.perfilPage.editData),
              leading: const Icon(Icons.person),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                context.goNamed(PAGES.editPerfilDatPer.pageName);
              },
            ),
            ListTile(
              title: Text(apptexts.perfilPage.editAddress),
              leading: const Icon(Icons.home),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                context.goNamed(PAGES.editPerfilDir.pageName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
