import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';

import 'package:flutter/material.dart';

import '../../../shared/widgets/buttons/buttons_custom.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WelcomePageView();
  }
}

class _WelcomePageView extends StatelessWidget {
  const _WelcomePageView();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);

    final textStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Stack(
            children: [
              // Image(
              //   image: const AssetImage(AppAssets.welcome),
              //   height: responsive.dp(75),
              //   fit: BoxFit.cover,
              // ),
              Positioned(
                bottom: responsive.dp(12),
                left: responsive.dp(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '!Bienvenido',
                      style: textStyle,
                    ),
                    Text(
                      'a la app',
                      style: textStyle,
                    ),
                    Text(
                      'Alumni',
                      style: textStyle,
                    ),
                    Text(
                      'Intisina!',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.hp(5)),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppLayoutConst.paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      AppRouter.router.go(PAGES.register.pagePath);
                    },
                    title: 'REGISTRATE',
                  ),
                ),
                const SizedBox(width: AppLayoutConst.spaceM),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      AppRouter.router.go(PAGES.login.pagePath);
                    },
                    title: 'INICIAR SESIÓN',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
