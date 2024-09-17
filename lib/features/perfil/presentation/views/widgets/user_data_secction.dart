import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_models/shared_models.dart';

import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'wid_address_card.dart';
import 'wid_personal_data_card.dart';

class UserDataSecction extends StatelessWidget {
  const UserDataSecction({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                apptexts.perfilPage.userData,
                style: Theme.of(context).textTheme.titleMedium,
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
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginS,
          ),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppLayoutConst.spaceZero),
          child: Column(
            children: [
              const SizedBox(height: AppLayoutConst.spaceL),
              PersonalDataCard(user: user),
              const SizedBox(height: AppLayoutConst.spaceXL),
              if (user.isClient) AddressCard(user: user),
            ],
          ),
        ),
        if (!user.hasAllRequiredFields && (user.isClient)) ...[
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text(
                apptexts.perfilPage.completeInformation,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                context.goNamed(PAGES.editPerfil.pageName);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
