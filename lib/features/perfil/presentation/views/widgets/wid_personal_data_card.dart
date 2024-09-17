import 'package:flutter/material.dart';

import 'package:shared_models/shared_models.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

class PersonalDataCard extends StatelessWidget {
  const PersonalDataCard({
    super.key,
    required this.user,
  });

  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.symmetric(horizontal: AppLayoutConst.marginL),
          child: Text(
            apptexts.perfilPage.userPersonalData,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppLayoutConst.spaceM),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppLayoutConst.cardBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: double.maxFinite),
                  _buildProfileInfo(apptexts.perfilPage.correo,
                      user.correoElectronico ?? '-'),
                  _buildProfileInfo(
                      apptexts.perfilPage.fullName, user.fullName),
                  _buildProfileInfo(
                      apptexts.perfilPage.username, user.nombreUsuario ?? '-'),
                  _buildProfileInfo(
                      apptexts.perfilPage.phone, user.numeroTelefono ?? '-'),
                  if (user is UsrCliente) ...[
                    _buildProfileInfo(apptexts.perfilPage.dob,
                        (user as UsrCliente).formattedFechaNacimiento),
                    _buildProfileInfo(apptexts.perfilPage.placeOfBirth,
                        (user as UsrCliente).lugarNacimiento ?? '-'),
                    _buildProfileInfo(apptexts.perfilPage.placeOfResidence,
                        (user as UsrCliente).lugarResidencia ?? '-'),
                  ]
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        '$label:',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
    );
  }
}
