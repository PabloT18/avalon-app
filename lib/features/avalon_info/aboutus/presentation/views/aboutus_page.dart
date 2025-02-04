import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutusPage extends StatelessWidget {
  const AboutusPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle linkStyle = TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
      decorationStyle: TextDecorationStyle.dashed,
      fontSize: 14,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avalon Plus'),
        elevation: 6,
      ),
      drawer: DrawerCustom(indexInitialName: PAGES.aboutus.pageName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppLayoutConst.paddingL)
            .copyWith(top: AppLayoutConst.paddingS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(
                AppAssets.logotipo,
                // height: 60,
              ),
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
            FadeInLeft(
              child: Text(
                apptexts.avalonInfo.aboutUs,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            FadeInUp(
              from: 10,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppLayoutConst.marginS,
                ),
                height: 1,
                color: AppColors.secondaryBlue.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 3),
            Text(apptexts.avalonInfo.aboutDescription),
            const SizedBox(height: AppLayoutConst.spaceXL),
            FadeInLeft(
              child: Text(
                apptexts.avalonInfo.services,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            FadeInUp(
              from: 10,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppLayoutConst.marginS,
                ),
                height: 1,
                color: AppColors.secondaryBlue.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 3),
            Text(apptexts.avalonInfo.servicesDescription),
            const SizedBox(height: AppLayoutConst.spaceXL),
            FadeInLeft(
              child: Text(
                'Contactanos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            FadeInUp(
              from: 10,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: AppLayoutConst.marginS,
                ),
                height: 1,
                color: AppColors.secondaryBlue.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 3),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${apptexts.avalonInfo.telefono}: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: () =>
                      UtilsFunctionsViews.makePhoneCall('+17139999885'),
                  child: const Text(
                    '+1 713-999-9885',
                    style: linkStyle,
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${apptexts.avalonInfo.fax}: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: () =>
                      UtilsFunctionsViews.makePhoneCall('+12815967287'),
                  child: const Text(
                    '+1 281-596-7287',
                    style: linkStyle,
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${apptexts.avalonInfo.email}: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const InkWell(
                  child: Text(
                    'am@avalonplus.com',
                    style: linkStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppLayoutConst.spaceL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () =>
                      _launchUniversalLinkIos('https://avalonplus.com/'),
                  child: Text(
                    'Visita nuestra web ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: () =>
                          _launchUniversalLinkIos('https://avalonplus.com/'),
                      splashColor: AppColors.primaryBlue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.globe,
                            color: AppColors.primaryBlue,
                            size: 35,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUniversalLinkIos(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    );
  }
}
