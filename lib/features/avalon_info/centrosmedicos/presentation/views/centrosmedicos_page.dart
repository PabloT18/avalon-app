import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/casos/presentation/views/widgets/wid_title_description.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/centrosmedicos_domain.dart';
import '../bloc/centros_medicos_bloc.dart';

class CentrosMedicosPage extends StatelessWidget {
  const CentrosMedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => CentrosMedicosBloc(
        user,
        repository: context.read<CentrosmedicosRepository>(),
      )..add(const GetCentrosMedicos()),
      child: const CentrosMedicosPageView(),
    );
  }
}

class CentrosMedicosPageView extends StatelessWidget {
  const CentrosMedicosPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final centrosMedicosBloc = context.read<CentrosMedicosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.centrosMedicos.title(n: 2)),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.centrosMedicos.pageName),
      body: BlocBuilder<CentrosMedicosBloc, CentrosMedicosState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              onRefresh: () async {
                centrosMedicosBloc.add(const GetCentrosMedicos());
              },
              refreshController: centrosMedicosBloc.refreshController,
              child: getChildByState(state, context, centrosMedicosBloc));
        },
      ),
    );
  }

  Widget getChildByState(
      CentrosMedicosState state, BuildContext context, centrosMedicosBloc) {
    return switch (state) {
      CentrosMedicosLoading() =>
        const Center(child: CircularProgressIndicator()),
      CentrosMedicosError() => MessageError(
          message: state.message,
          onTap: () {
            centrosMedicosBloc.add(const GetCentrosMedicos());
          }),
      CentrosMedicosLoaded() => ListView(
          children: [
            for (final centromedico in state.centrosMedicos)
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
                  leading: const FaIcon(FontAwesomeIcons.hospital),
                  title: Text(centromedico.nombre ?? ''),
                  subtitle: Text(centromedico.descripcion ?? ''),
                  expandedAlignment: Alignment.centerLeft,
                  childrenPadding: const EdgeInsets.all(AppLayoutConst.paddingL)
                      .copyWith(top: AppLayoutConst.spaceS),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleDescripcion(
                        isSubdescription: true,
                        title: apptexts.perfilPage.correo,
                        value: centromedico.correoElectronico ?? ' -'),
                    if (centromedico.direccion != null) ...[
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.perfilPage.address,
                          value: centromedico.direccion!.direccionCompleta),
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.perfilPage.country,
                          value: centromedico.direccion!.pais?.nombre ?? ' -'),
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.perfilPage.state,
                          value:
                              centromedico.direccion!.estado?.nombre ?? ' -'),
                      TitleDescripcion(
                          isSubdescription: true,
                          title: apptexts.perfilPage.zipCode,
                          value: centromedico.direccion!.codigoPostal ?? ' -'),
                    ]
                  ],
                ),
              ),
          ],
        ),
    };
  }
}
