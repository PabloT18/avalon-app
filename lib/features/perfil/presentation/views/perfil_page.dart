import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:avalon_app/app/app.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_models/shared_models.dart';

import '../../../membresias/presentation/views/widgets/wid_membresia_card.dart';
import 'widgets/wid_address_card.dart';
import 'widgets/wid_personal_data_card.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key, this.isPage = false});

  final bool isPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppLayoutConst.paddingL)
          .copyWith(top: AppLayoutConst.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const UserMembershipSecction(),
          const SizedBox(height: AppLayoutConst.spaceXL),
          BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) {
              return previous.user != current.user;
            },
            builder: (context, state) {
              return UserDataSecction(user: state.user);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UserMembershipSecction extends StatelessWidget {
  const UserMembershipSecction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apptexts.membresiasPage.membresia(n: 1),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginM,
          ),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),
        const SizedBox(height: AppLayoutConst.spaceL),
        const MembresiaCard(),
      ],
    );
  }
}

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
                style: Theme.of(context).textTheme.titleSmall,
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
        // Center(
        //   child: Container(
        //     width: 100,
        //     margin:
        //         const EdgeInsets.symmetric(vertical: AppLayoutConst.marginL),
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        //     clipBehavior: Clip.hardEdge,
        //     child: FadeIn(
        //       child: Image.network(
        //         user.urlImagen ?? 'https://via.placeholder.com/150',
        //         width: 100,
        //         height: 100,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppLayoutConst.spaceZero),
          child: Column(
            children: [
              const SizedBox(height: AppLayoutConst.spaceL),
              PersonalDataCard(user: user),
              const SizedBox(height: AppLayoutConst.spaceXL),
              AddressCard(user: user),
            ],
          ),
        ),
        if (!user.hasAllRequiredFields) ...[
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
