import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';

class EditableTextAreaDescription extends StatelessWidget {
  const EditableTextAreaDescription(
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
            maxLines: 3, // Permitir un máximo de 3 líneas
            controller: controller,
            decoration: const InputDecoration(
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
