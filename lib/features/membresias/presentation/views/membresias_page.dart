import 'package:flutter/material.dart';
import 'package:alumni_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:alumni_app/core/config/responsive/responsive_layouts.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/core/config/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembresiasPage extends StatelessWidget {
  const MembresiasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Membresias'),
        elevation: 6,
      ),
      drawer: const DrawerCustom(
        indexInitial: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppLayoutConst.paddingL),
        child: Column(
          children: [
            const Text('En desarrollo'),
            const Text('Listado de historial de membresias actual y caducadas'),
            MembresiaCard3(
              id: user.id!.toString(),
            ),
            FadeIn(
              child: Card(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  constraints: const BoxConstraints(minHeight: 135),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.grey,
                        Colors.grey.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Opacity(
                          opacity: 0.6,
                          child: Image.asset(
                            AppAssets.isotipo4,
                            height: 80,
                          ),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Membresía: Gold',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Gold 12 Meses', style: TextStyle(fontSize: 12)),
                          Text('EXP 2023-07-02',
                              style: TextStyle(fontSize: 12)),
                          Text('Expirada', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MembresiaCard3 extends StatefulWidget {
  const MembresiaCard3({super.key, required this.id});

  final String id;
  @override
  State<MembresiaCard3> createState() => _MembresiaCardState();
}

class _MembresiaCardState extends State<MembresiaCard3> {
  Future<List<dynamic>> fetchMembresia(String id) async {
    final String url =
        'http://149.56.110.32:8086/clientes/$id/clienteMembresias';
    final dio = Dio();
    const String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      return response.data;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<dynamic>>? _futureMembresia;
  @override
  void initState() {
    super.initState();
    _futureMembresia = fetchMembresia(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppBloc>().state.user;

    return FutureBuilder<List<dynamic>>(
      // future: fetchMembresia(user.id!.toString()),
      future: _futureMembresia,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Opacity(
            opacity: 0.5,
            child: Container(
              constraints: const BoxConstraints(minHeight: 135),
              width: double.maxFinite,
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cargando membresía...'),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            constraints: const BoxConstraints(minHeight: 135),
            width: double.maxFinite,
            child: Card(
              color: Colors.redAccent,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _futureMembresia = fetchMembresia(widget.id);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Error al cargar la membresía.'),
                      Text('Tap para reintentar.'),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            constraints: const BoxConstraints(minHeight: 135),
            width: double.maxFinite,
            child: Card(
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _futureMembresia = fetchMembresia(widget.id);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No hay membresías asignadas'),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          final membresia = snapshot.data![0]['membresia'];
          return FadeIn(
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                constraints: const BoxConstraints(minHeight: 135),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.secondaryBlue.withOpacity(0.2),
                      AppColors.secondaryBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.asset(
                          AppAssets.isotipo4,
                          height: 80,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Membresía: ${membresia['nombres']}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${membresia['detalle']}',
                            style: const TextStyle(fontSize: 12)),
                        Text('EXP ${snapshot.data![0]['fechaFin']}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
