import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/shared/widgets/alerts/alert_message_error.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/formaspago_domain.dart';
import '../bloc/bloc/formas_pago_bloc.dart';

class FormasPagoPage extends StatelessWidget {
  const FormasPagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppBloc>().state as AppAuthenticated).user;

    return BlocProvider(
      create: (context) => FormasPagoBloc(
        user,
        repository: context.read<FormasPagoRepository>(),
      )..add(const GetMetodosPagoEvent()),
      child: const FormasPagoPageView(),
    );
  }
}

class FormasPagoPageView extends StatelessWidget {
  const FormasPagoPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formasPagoBloc = context.read<FormasPagoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formaspago'),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.formasPago.pageName),
      body: BlocBuilder<FormasPagoBloc, FormasPagoState>(
        builder: (context, state) {
          return SmartRefrehsCustom(
              key: const Key('__formaspag_list_key__'),
              onRefresh: () async {
                formasPagoBloc.add(const GetMetodosPagoEvent());
              },
              refreshController: formasPagoBloc.refreshController,
              child: getChildByState(state, context, formasPagoBloc));
        },
      ),
    );
  }

  Widget getChildByState(
      FormasPagoState state, BuildContext context, formasPagoBloc) {
    return switch (state) {
      FormasPagoInitial() => const Center(child: CircularProgressIndicator()),
      FormasPagoLoading() => const Center(child: CircularProgressIndicator()),
      FormasPagoError() => MessageError(
          message: state.message,
          onTap: () {
            formasPagoBloc.add(const GetMetodosPagoEvent());
          }),
      FormasPagoLoaded() => ListView(
          children: [
            for (final metodoPago in state.metodosPago)
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
                child: ListTile(
                  // dense: true,
                  leading: const FaIcon(FontAwesomeIcons.wallet),
                  title: Text(metodoPago.nombre ?? ''),
                  subtitle: Text(metodoPago.descripcion ?? ''),
                ),
              )
          ],
        ),
    };
  }
}
