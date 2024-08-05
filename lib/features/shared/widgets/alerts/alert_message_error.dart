import 'package:alumni_app/core/config/responsive/responsive_class.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageError extends StatelessWidget {
  const MessageError({
    required this.message,
    required this.onTap,
    super.key,
  });

  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCustom.of(context);
    // final darkTheme = context.read<AppSettingsCubit>().isDarkTheme;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: responsive.wp(12)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: InkWell(
          splashColor: AppColors.grey.withOpacity(0.5),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppLayoutConst.paddingL),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error,
                  color: AppColors.secondaryBlue,
                ),
                const SizedBox(width: AppLayoutConst.spaceL),
                Expanded(child: Text(message)),
                const SizedBox(height: AppLayoutConst.spaceS),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
