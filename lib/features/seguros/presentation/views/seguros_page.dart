import 'package:alumni_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:alumni_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SegurosPage extends StatefulWidget {
  const SegurosPage({super.key});

  @override
  State<SegurosPage> createState() => _SegurosPageState();
}

class _SegurosPageState extends State<SegurosPage> {
  Future<List<dynamic>>? _futurePolizas;
  late String id;
  @override
  void initState() {
    final user = context.read<AppBloc>().state.user;
    id = user.id!.toString();
    super.initState();
    _futurePolizas = fetchPolizas();
  }

  Future<List<dynamic>> fetchPolizas() async {
    final String url = 'http://149.56.110.32:8086/clientes/$id/clientesPolizas';
    const String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

    final dio = Dio();
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

  void _showPolizaDetails(BuildContext context, dynamic poliza) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(poliza['poliza']['nombre']),
          // scrollable: true,

          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.45,
            ),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Descripción: ${poliza['poliza']['descripcion']}'),
                  Text(
                      'Cliente: ${poliza['cliente']['nombres']} ${poliza['cliente']['apellidos']}'),
                  Text('Correo: ${poliza['cliente']['correoElectronico']}'),
                  Text(
                      'Asesor: ${poliza['asesor']['nombres']} ${poliza['asesor']['apellidos']}'),
                  Text(
                      'Correo del asesor: ${poliza['asesor']['correoElectronico']}'),
                  Text(
                      'Agente: ${poliza['agente']['nombres']} ${poliza['agente']['apellidos']}'),
                  Text(
                      'Correo del agente: ${poliza['agente']['correoElectronico']}'),
                  Text(
                      'Aseguradora: ${poliza['poliza']['aseguradora']['nombre']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                  Text('Fecha de inicio: ${poliza['fechaInicio']}'),
                  Text('Fecha de fin: ${poliza['fechaFin']}'),
                  Text('Estado: ${poliza['estado']}'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguros'),
        elevation: 6,
      ),
      drawer: const DrawerCustom(
        indexInitial: 2,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futurePolizas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _futurePolizas = fetchPolizas();
                });
              },
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Problemas de conexión. Toca para reintentar'),
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _futurePolizas = fetchPolizas();
                });
              },
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        Text('No se encontraron pólizas. Toca para reintentar'),
                  ),
                ),
              ),
            );
          } else {
            final polizas = snapshot.data!;
            return SmartRefrehsCustom(
              key: const Key('__noticias_list_key__'),
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                refreshController
                  ..refreshCompleted()
                  ..loadComplete();
                setState(() {
                  _futurePolizas = fetchPolizas();
                });
              },
              refreshController: refreshController,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: polizas.length,
                itemBuilder: (context, index) {
                  final poliza = polizas[index];
                  return SizedBox(
                    height: 100,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          _showPolizaDetails(context, poliza);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(poliza['poliza']['nombre'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              subtitle: Text(
                                'Aseguradora ' +
                                    poliza['poliza']['aseguradora']['nombre'],
                                textAlign: TextAlign.center,
                              ),
                              titleAlignment: ListTileTitleAlignment.center,
                            ),
                            if (poliza['poliza']['aseguradora']['urlImagen'] !=
                                null)
                              Image.network(
                                poliza['poliza']['aseguradora']['urlImagen'],
                                fit: BoxFit.cover,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
