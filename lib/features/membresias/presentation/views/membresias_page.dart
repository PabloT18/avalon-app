import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/membresias/membresias.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';

import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembresiasPage extends StatelessWidget {
  const MembresiasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apptexts.membresiasPage.membresia(n: 2)),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.membresias.pageName),
      body: BlocBuilder<AppBloc, AppState>(
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

          var singleChildScrollView = SingleChildScrollView(
              padding: const EdgeInsets.all(AppLayoutConst.paddingL),
              child: Column(children: [
                // Text(
                //   apptexts.membresiasPage.membresia(n: 2),
                //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                // ),
                _MemberCard(memship: state.membresias[0]),
                for (int i = 1; i < state.membresias.length; i++)
                  Opacity(
                      opacity: 0.5,
                      child: _MemberCard(memship: state.membresias[i]))
              ]));
          return singleChildScrollView;
        },
      ),
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

class _MemberCard extends StatelessWidget {
  const _MemberCard({super.key, required this.memship});

  final MembresiaRegister memship;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);

    return Container(
      clipBehavior: Clip.hardEdge,
      width: responsive.wp(90),
      height: responsive.hp(25),
      margin: const EdgeInsets.only(bottom: AppLayoutConst.spaceL),
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
                      memship.cliente!.fullNameLN.toUpperCase(),
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
                            value: memship.cliente!.id.toString() * 4,
                          ),
                          _MembresiaCardDetail(
                              detail: 'DOB',
                              value: memship.cliente!.fechaNacimientoFormat),
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
  }
}
