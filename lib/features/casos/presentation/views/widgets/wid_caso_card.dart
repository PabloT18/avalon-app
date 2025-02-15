import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/casos/domain/casos_domain.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'wid_title_description.dart';

class CaseCard extends StatelessWidget {
  const CaseCard({super.key, required this.caso, this.enable = true});

  final CasoEntity caso;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.secondaryBlue.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppLayoutConst.cardBorderRadius),
      ),
      child: ListTile(
        onTap: enable
            ? () {
                context.goNamed(
                  PAGES.detaleCaso.pageName,
                  pathParameters: {
                    'casoId': caso.id?.toString() ?? '',
                  },
                  extra: caso,
                );
              }
            : null,
        title: TitleDescripcion(
            title: apptexts.appOptions.cliente,
            value: caso.clienteDisplayName ?? ' - '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppLayoutConst.spaceM,
            ),
            TitleDescripcion(
                isSubdescription: true,
                title: apptexts.appOptions.diagnostico_sintonomas,
                value: caso.observaciones ?? ' - '),
            TitleDescripcion(
                isSubdescription: true,
                title: apptexts.segurosPage.polizaSeguros(n: 1),
                value: caso.clientePoliza?.displayName?.toString() ?? ' - '),
            TitleDescripcion(
                isSubdescription: true,
                title: '${apptexts.casosPage.title(n: 1)} Id',
                value: caso.codigo?.toString() ?? ' - '),
          ],
        ),
      ),
    );
  }
}

// class CaseCard extends StatelessWidget {
//   const CaseCard({super.key, required this.caso});

//   final CasoEntity caso;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: AppLayoutConst.marginM),
//       constraints: const BoxConstraints(
//         minHeight: 100,
//       ),
//       // alignment: Alignment.center,
//       child: Card(
//         elevation: 4,
//         child: ListTile(
//           onTap: () {
//             context.goNamed(
//               PAGES.detaleCaso.pageName,
//               pathParameters: {
//                 'casoId': caso.id?.toString() ?? '',
//               },
//               extra: caso,
//             );
//           },
//           title: TitleDescripcion(
//               title: apptexts.appOptions.cliente,
//               value: caso.clienteDisplayName ?? ' - '),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TitleDescripcion(
//                   isSubdescription: true,
//                   title: '${apptexts.casosPage.title(n: 1)} Id',
//                   value: caso.codigo?.toString() ?? ' - '),
//               TitleDescripcion(
//                   isSubdescription: true,
//                   title: apptexts.appOptions.detalle(n: 1),
//                   value: caso.observaciones ?? ' - '),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
