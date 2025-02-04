import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:flutter/material.dart';

class DetailFormField extends StatelessWidget {
  const DetailFormField({
    super.key,
    this.label,
    this.value,
    this.colorGray = false,
  });

  final String? label;
  final String? value;
  final bool colorGray;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
