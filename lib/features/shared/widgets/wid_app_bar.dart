import 'package:alumni_app/core/config/router/app_router.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    required this.title,
    this.isHome = false,
    this.icon,
    this.route,
  });

  final String title;
  final bool isHome;
  // final bool isHome;

  final String? route;

  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
      centerTitle: false,
      leading: Container(
        height: 10,
        width: 10,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.secondaryBlue,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: isHome
                ? null
                : () {
                    // AppRouter.router.go(route ?? PAGES.menu.pagePath);
                  },
            child: Center(
                child: icon ??
                    Image.asset(
                      AppAssets.isotipo1,
                      height: 16,
                    )),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
