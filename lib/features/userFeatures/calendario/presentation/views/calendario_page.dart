import 'package:flutter/material.dart';
import '../../../../shared/widgets/wid_app_bar.dart';

class CalendarioPage extends StatelessWidget {
  const CalendarioPage({
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
