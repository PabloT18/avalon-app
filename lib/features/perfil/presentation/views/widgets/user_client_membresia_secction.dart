import 'package:flutter/material.dart';

import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/membresias/presentation/views/widgets/wid_membresia_card.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';

class UserMembershipSecction extends StatelessWidget {
  const UserMembershipSecction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          apptexts.membresiasPage.membresia(n: 1),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppLayoutConst.marginM,
          ),
          height: 1,
          color: AppColors.secondaryBlue.withOpacity(0.5),
        ),
        const SizedBox(height: AppLayoutConst.spaceL),
        const MembresiaCard(),
      ],
    );
  }
}
