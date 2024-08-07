import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPerfilOptionsPage extends StatelessWidget {
  const EditPerfilOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Editar Datos Personales'),
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
              title: const Text('Editar Dirección'),
              leading: const Icon(Icons.home),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                context.goNamed(PAGES.editPerfilDatPer.pageName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
