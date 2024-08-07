import 'package:flutter/material.dart';
import 'package:avalon_app/app/app.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_router.dart';

import 'package:animate_do/animate_do.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/wid_membresia.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key, this.isPage = false});

  final bool isPage;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Membresias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                MembresiaCard(
                  id: user.id!.toString(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Datos del Usuario',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.goNamed(PAGES.editPerfil.pageName);
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 100,
              margin:
                  const EdgeInsets.symmetric(vertical: AppLayoutConst.marginL),
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              clipBehavior: Clip.hardEdge,
              child: FadeIn(
                child: Image.network(
                  user.urlImagen ?? 'https://via.placeholder.com/150',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(15),
                  ),
              elevation: 2,
              shadowColor: Colors.transparent,
              borderOnForeground: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Datos Personales',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildProfileInfo('Correo Electrónico:',
                        user.correoElectronico ?? 'No disponible'),
                    _buildProfileInfo('Nombre Completo:', user.fullName),
                    _buildProfileInfo('Nombre de Usuario:',
                        user.nombreUsuario ?? 'No disponible'),
                    _buildProfileInfo(
                        'Número de Teléfono:', user.numeroTelefono ?? '-'),
                  ],
                ),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: const Divider()),
          // const SizedBox(height: 20),
          Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(15),
                  ),
              elevation: 2,
              shadowColor: Colors.transparent,
              borderOnForeground: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Dirección',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!user.isAddressComplete)
                      Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              context.goNamed(PAGES.editPerfil.pageName);
                            },
                            child: const Text(
                              'No ha registrado su dirección completa',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          )),
                    if (user.isAddressComplete) ...[
                      Text(
                        user.direccion?.direccionUno ?? 'Dir 1 ',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        user.direccion?.direccionDos ?? 'Dir 2 ',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        user.direccion?.state?.estadoNombreCompleto ??
                            'Azuay, Ecuador',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        user.direccion?.ciudad ?? 'Cuenca',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        user.direccion?.codigoPostal ?? '010101',
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              )),
          _buildProfileInfo(
              'Fecha de Nacimiento:', user.formattedFechaNacimiento),
          _buildProfileInfo(
              'Lugar de Nacimiento:', user.lugarNacimiento ?? '-'),
          _buildProfileInfo(
              'Lugar de Residencia:', user.lugarResidencia ?? '-'),
          if (!user.hasAllRequiredFields) ...[
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: const Text(
                  'Por favor, completa tu información personal !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? 'No especificado',
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoRow2(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value ?? 'No especificado',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
