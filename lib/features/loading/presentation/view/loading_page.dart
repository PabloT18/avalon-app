import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';

import 'package:avalon_app/core/config/responsive/responsive.dart';

import 'package:avalon_app/core/config/router/app_routes_assets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<AppBloc>().add(const AppValidate());

    return const _LoadingPageView();
  }
}

class _LoadingPageView extends StatefulWidget {
  const _LoadingPageView();

  @override
  State<_LoadingPageView> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<_LoadingPageView> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    return Scaffold(
        body: FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Spacer(),
          ZoomIn(
            child: Center(
              child: Hero(
                tag: '__tag_logo__',
                child: Image(
                  height: responsive.hp(12),
                  image: const AssetImage(AppAssets.logotipo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          FadeIn(
            delay: const Duration(milliseconds: 750),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 2,
                width: responsive.wp(60),
                child: const LinearProgressIndicator(),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
