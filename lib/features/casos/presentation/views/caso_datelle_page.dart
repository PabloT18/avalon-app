import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CasoDetallePage extends StatelessWidget {
  const CasoDetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder al parametro 'casoId' desde el state
    final String? casoId = GoRouterState.of(context).pathParameters['casoId'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('CasoDetallePage'),
      ),
      body: Center(
        child: Text(casoId ?? ''),
      ),
    );
  }
}
