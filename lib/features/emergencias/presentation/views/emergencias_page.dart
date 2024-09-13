import 'package:flutter/material.dart';

// import 'package:avalon/features/shared/widgets/wid_drawer.dart';

class EmergenciasPage extends StatelessWidget {
  const EmergenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergencias'),
        elevation: 6,
      ),
      // drawer: const DrawerCustom(
      //     indexInitial: x,
      // ),
      body: const Center(
        child: Text('Welcome to Emergencias'),
      ),
    );
  }
}
