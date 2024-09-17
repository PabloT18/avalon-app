import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/app/app.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';

import 'widgets/user_asesor_agente_mem_secction.dart';
import 'widgets/user_client_membresia_secction.dart';
import 'widgets/user_data_secction.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key, this.isPage = false});

  final bool isPage;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.perfilPage.userData),
        elevation: 6,
      ),
      // drawer: DrawerCustom(indexInitialName: PAGES.medicos.pageName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppLayoutConst.paddingL)
            .copyWith(top: AppLayoutConst.paddingXL),
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) {
            return previous.user != current.user;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (state.user.isClient) const UserMembershipSecction(),
                if (!state.user.isClient)
                  const UserAgenteAsesorMembershipSecction(),
                const SizedBox(height: AppLayoutConst.spaceXL),
                UserDataSecction(user: state.user),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
