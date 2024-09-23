import 'dart:ui';

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MembresiaCard extends StatelessWidget {
  const MembresiaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is! AppAuthenticated) {
          return Opacity(
            opacity: 0.5,
            child: Container(
              constraints: const BoxConstraints(minHeight: 135),
              width: double.maxFinite,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(apptexts.membresiasPage.loadingMembresias),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (state.membresias.isEmpty) {
          return Container(
            constraints: const BoxConstraints(minHeight: 135),
            width: double.maxFinite,
            child: Card(
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  final appBloc = context.read<AppBloc>();
                  appBloc.add(AppGetMembresias(appBloc.state.user));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(apptexts.membresiasPage.noMembresias),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        final membresiaRegistro = state.membresias[0];

        final responsive = ResponsiveCustom.of(context);
        return Container(
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
                          membresiaRegistro.cliente!.fullNameLN.toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: responsive.hp(2)),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _MembresiaCardDetail(
                                detail: 'MEMBER ID',
                                value:
                                    membresiaRegistro.cliente!.id.toString() *
                                        4,
                              ),
                              _MembresiaCardDetail(
                                  detail: 'DOB',
                                  value: membresiaRegistro
                                      .cliente!.fechaNacimientoFormat),
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
        );
      },
    );
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
