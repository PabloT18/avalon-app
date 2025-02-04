import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:flutter/material.dart';

class DetailFormField extends StatelessWidget {
  const DetailFormField({
    super.key,
    this.label,
    this.value,
    this.colorGray = false,
    this.padding = AppLayoutConst.marginM,
  });

  final String? label;
  final String? value;
  final bool colorGray;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
          ],
          TextFormField(
            initialValue: value ?? ' - ',
            enabled: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: colorGray ? Colors.black54 : null,
                ),
          ),
        ],
      ),
    );
  }
}
