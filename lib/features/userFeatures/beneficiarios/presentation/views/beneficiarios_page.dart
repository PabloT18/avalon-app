import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/core/config/responsive/responsive_class.dart';

import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/widgets.dart';

import '../../../../shared/widgets/app_widgets.dart';

class BeneficiariosPage extends StatelessWidget {
  const BeneficiariosPage({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    String nombre = "Ana  Carolina";
    String apellido = "Ávila Barba";
    String correo = "favila@gmail.com";

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarCustom(title: title),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppLayoutConst.paddingL),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: responsive.hp(1)),
                    Center(
                      child: Image.asset(
                        AppAssets.logotipo,
                        height: responsive.dp(7),
                      ),
                    ),
                    SizedBox(height: responsive.hp(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: responsive.wp(45),
                          child: const UserPhoto(),
                        ),
                        SizedBox(width: responsive.wp(5)),
                        SizedBox(
                          height: responsive.wp(30),
                          child: const UserQr(
                            code: 'dfsafsafsafdsafadsf',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.hp(6)),
                    Text(
                      nombre,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      apellido,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      correo,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    SizedBox(height: responsive.hp(8)),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppLayoutConst.paddingL),
            child: CustomButton(
              onPressed: () {
                // AppRouter.router.go(PAGES.register.pagePath);
              },
              backgroundColor: AppColors.threeBlue,
              onPrimary: Colors.white,
              title: 'ELIMINIAR BENEFICIARIO',
            ),
          ),
          SizedBox(height: responsive.hp(5)),
        ],
      ),
    );
  }
}
