import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/router/app_routes_assets.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembresiaCard extends StatefulWidget {
  const MembresiaCard({super.key, required this.id});

  final String id;
  @override
  State<MembresiaCard> createState() => _MembresiaCardState();
}

class _MembresiaCardState extends State<MembresiaCard> {
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
                  // image: const DecorationImage(
                  //   image: AssetImage(AppAssets.isotipo1), // Ruta de tu imagen
                  //   alignment: Alignment.bottomRight,
                  //   scale: 1,
                  //   opacity: 0.5,
                  // ),
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
