import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/material.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({
    super.key,
    this.pathImage,
  });

  final String? pathImage;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);

    return Container(
      //     margin: EdgeInsets.only(
      //         bottom: maxHeight == null
      // ? constraints!.maxHeight * 0.02
      // : maxHeight! * 0.02),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          // color: AppColors.secondaryBlue.withOpacity(0.2), width: 2),
          //       boxShadow: <BoxShadow>[
          //         BoxShadow(
          // color: AppColors.secondaryBlue.withOpacity(0.8),
          // blurRadius: 5.0,
          // offset: const Offset(0, 3)),
          //       ],
          color: Colors.white,
        ),
      ),
      // width: sizeUserAvatar,
      height: responsive.dp(18),
      child: ClipOval(
        child: Image.asset(
          AppAssets.iconUserfoto,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
