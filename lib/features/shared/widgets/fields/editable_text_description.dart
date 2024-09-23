import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

class EditableTextDescription extends StatelessWidget {
  const EditableTextDescription(
    this.label,
    this.controller, {
    super.key,
    this.beNull = false,
  });

  final TextEditingController controller;
  final String label;
  final bool beNull;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: AppLayoutConst.spaceM,
          ),
          TextFormField(
            maxLength: 250, // Limitar el número máximo de caracteres

            controller: controller,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            validator: (value) {
              if (beNull) {
                return null;
              }
              if (value == null || value.isEmpty) {
                return apptexts.appOptions.validators.requiredField;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
