import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:flutter/material.dart';

class DetailFormField extends StatelessWidget {
  const DetailFormField({
    super.key,
    required this.label,
    this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
          ),
          const SizedBox(height: AppLayoutConst.spaceM),
          TextFormField(
            initialValue: value ?? ' - ',
            enabled: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            // style: const TextStyle(
            //   fontSize: 14, // Ajusta el tamaño de texto a 14 como en el tema
            //   fontFamily: 'Sora', // Asegura que el estilo de texto coincida
            //   color: Colors.black, // Asegura que el color de texto coincida
            // ),
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
        ],
      ),
    );
  }
}
