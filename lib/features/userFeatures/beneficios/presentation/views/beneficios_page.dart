import 'package:flutter/material.dart';
import '../../../../shared/widgets/wid_app_bar.dart';

class BeneficiosPage extends StatelessWidget {
  const BeneficiosPage({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarCustom(title: title),
    );
  }
}
