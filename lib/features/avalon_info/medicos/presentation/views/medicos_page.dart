import 'package:avalon_app/app/app.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/medicos_domain.dart';
import '../bloc/medicos_bloc.dart';

class MedicosPage extends StatelessWidget {
  const MedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => MedicosBloc(
        user,
        repository: context.read<MedicosRepository>(),
      )..add(const GetMedicos()),
      child: const MedicosPageView(),
    );
  }
}

class MedicosPageView extends StatelessWidget {
  const MedicosPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final medicosBloc = context.read<MedicosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.medicosPage.title(n: 2)),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.medicos.pageName),
      body: BlocBuilder<MedicosBloc, MedicosState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__medicos_list_key__'),
              onRefresh: () async {
                medicosBloc.add(const GetMedicos());
              },
              refreshController: medicosBloc.refreshController,
              child: getChildByState(state, medicosBloc));
        },
      ),
    );
  }

  Widget getChildByState(MedicosState state, medicosBloc) {
    return switch (state) {
      MedicosLoading() => const Center(child: CircularProgressIndicator()),
      MedicosError() => MessageError(
          message: state.message,
          onTap: () {
            medicosBloc.add(const GetMedicos());
          }),
      MedicosLoaded() => ListView(
          children: [
            for (final medico in state.medicos)
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors.secondaryBlue.withOpacity(0.4),
                    width: 1,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppLayoutConst.cardBorderRadius),
                ),
                elevation: 1,
                child: ExpansionTile(
                    dense: true,
                    leading: const FaIcon(FontAwesomeIcons.userDoctor),
                    title: Text(medico.fullName),
                    subtitle: Text(medico.especialidad?.nombre ?? ''),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding:
                        const EdgeInsets.all(AppLayoutConst.paddingL)
                            .copyWith(top: AppLayoutConst.spaceS),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.medicosPage.medicoEmail,
                          value: medico.correoElectronico ?? ' -'),
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.medicosPage.medicoSpecialty,
                          value: medico.especialidad?.nombre ?? ' -'),
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.medicosPage.medicoSpecialtyDetail,
                          value: medico.especialidad?.descripcion ?? ' -'),
                      if (medico.direccion != null) ...[
                        TitleDescripcion(
                            isSubdescription: true,
                            title: apptexts.medicosPage.medicoAddress,
                            value: medico.direccion!.direccionCompleta),
                        TitleDescripcion(
                            isSubdescription: true,
                            title: apptexts.medicosPage.medicoCountry,
                            value: medico.direccion!.pais?.nombre ?? ' -'),
                        TitleDescripcion(
                            isSubdescription: true,
                            title: apptexts.medicosPage.medicoState,
                            value: medico.direccion!.estado?.nombre ?? ' -'),
                        TitleDescripcion(
                            isSubdescription: true,
                            title: apptexts.medicosPage.medicoZipCode,
                            value: medico.direccion!.codigoPostal ?? ' -'),
                      ]
                    ]),
              ),
          ],
        ),
    };
  }
}
