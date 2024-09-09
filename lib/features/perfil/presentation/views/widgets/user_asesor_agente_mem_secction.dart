import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

class UserAgenteAsesorMembershipSecction extends StatelessWidget {
  const UserAgenteAsesorMembershipSecction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is! AppAuthenticated) {
          return const Center(
            child: CircularProgressIndicatorCustom(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userTypeName(state.user),
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
            Container(
              clipBehavior: Clip.hardEdge,
              width: responsive.wp(90),
              height: responsive.hp(25),
              decoration: BoxDecoration(
                color: AppColors.cardBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: responsive.hp(-10),
                    right: responsive.wp(-19),
                    child: Stack(
                      children: [
                        Image.asset(
                          AppAssets.isotipo4,
                          fit: BoxFit.cover,
                          height: responsive.hp(35),
                          // color: Colors.white,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.cardBlue.withOpacity(0.3),
                                  AppColors.cardBlue,
                                ],
                                stops: const [
                                  0.6,
                                  0.75,
                                ], // Ajusta estos valores para controlar la posición del difuminado
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppAssets.logotipo5,
                        height: responsive.hp(7.5),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(AppLayoutConst.paddingL)
                            .copyWith(bottom: AppLayoutConst.paddingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.fullName.toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            SizedBox(height: responsive.hp(2)),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  _MembresiaCardDetail(
                                    detail: apptexts.appOptions.rol,
                                    value:
                                        userTypeName(state.user).toUpperCase(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String userTypeName(User user) {
    if (user.isClient) {
      return apptexts.appOptions.cliente;
    } else if (user.userRol == UserRol.agente) {
      return apptexts.appOptions.agente;
    } else if (user.userRol == UserRol.asesor) {
      return apptexts.appOptions.asesor;
    } else if (user.userRol == UserRol.admin) {
      return apptexts.appOptions.administrador;
    } else {
      return apptexts.appOptions.cliente;
    }
  }
}

class _MembresiaCardDetail extends StatelessWidget {
  const _MembresiaCardDetail({
    super.key,
    required this.value,
    required this.detail,
  });

  final String detail;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white.withOpacity(0.5)),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
