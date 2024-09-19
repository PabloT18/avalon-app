import 'package:flutter/material.dart';

class ReclamacionDetalle extends StatelessWidget {
  const ReclamacionDetalle({super.key, this.reclamacion});

  final Object? reclamacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReclamacionDetalle'),
      ),
      body: const Center(
        child: Text('ReclamacionDetalle'),
      ),
    );
  }
}
