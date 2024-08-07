// import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class FamiliaresPage extends StatefulWidget {
//   const FamiliaresPage({super.key});

//   @override
//   State<FamiliaresPage> createState() => _FamiliaresPageState();
// }

// class _FamiliaresPageState extends State<FamiliaresPage> {
//   Future<List<dynamic>>? _futurePolizas;
//   Future<List<dynamic>>? _futureFamiliares;
//   dynamic _selectedPoliza;

//   @override
//   void initState() {
//     super.initState();
//     _futurePolizas = fetchPolizas();
//   }

//   Future<List<dynamic>> fetchPolizas() async {
//     const String url = 'http://149.56.110.32:8086/clientes/152/clientesPolizas';
//     const String token =
//         'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'Authorization': token,
//           },
//         ),
//       );
//       return response.data;
//     } catch (e) {
//       print('Error fetching data: $e');
//       throw Exception('Error fetching data');
//     }
//   }

//   Future<List<dynamic>> fetchFamiliares(int polizaId) async {
//     final String url =
//         'http://149.56.110.32:8086/clientesPolizas/$polizaId/cargasFamiliares';
//     const String token =
//         'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         url,
//         options: Options(
//           headers: {
//             'Authorization': token,
//           },
//         ),
//       );
//       return response.data;
//     } catch (e) {
//       print('Error fetching data: $e');
//       throw Exception('Error fetching data');
//     }
//   }

//   void _selectPoliza(dynamic poliza) {
//     setState(() {
//       _selectedPoliza = poliza;
//       _futureFamiliares = fetchFamiliares(poliza['id']);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final refreshController = RefreshController(initialRefresh: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Familiares'),
//         elevation: 6,
//       ),
//       drawer: const DrawerCustom(
//         indexInitial: 3,
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: _futurePolizas,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _futurePolizas = fetchPolizas();
//                 });
//               },
//               child: const Center(
//                 child: Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text('Problemas de conexión. Toca para reintentar'),
//                   ),
//                 ),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _futurePolizas = fetchPolizas();
//                 });
//               },
//               child: const Center(
//                 child: Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child:
//                         Text('No se encontraron pólizas. Toca para reintentar'),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             final polizas = snapshot.data!;
//             return SmartRefrehsCustom(
//               key: const Key('__noticias_list_key__'),
//               onRefresh: () async {
//                 await Future.delayed(const Duration(seconds: 1));
//                 setState(() {
//                   _futurePolizas = fetchPolizas();
//                   _selectedPoliza = null;
//                   _futureFamiliares = null;
//                 });
//                 refreshController
//                   ..refreshCompleted()
//                   ..loadComplete();
//               },
//               refreshController: refreshController,
//               child: ListView(
//                 children: [
//                   ...polizas.map((poliza) {
//                     return Card(
//                       clipBehavior: Clip.hardEdge,
//                       child: InkWell(
//                         onTap: () {
//                           _selectPoliza(poliza);
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ListTile(
//                               title: Text(poliza['poliza']['nombre']),
//                               subtitle: Text(
//                                 'Aseguradora: ${poliza['poliza']['aseguradora']['nombre']}',
//                               ),
//                             ),
//                             if (poliza['poliza']['aseguradora']['urlImagen'] !=
//                                 null)
//                               Image.network(
//                                 poliza['poliza']['aseguradora']['urlImagen'],
//                                 fit: BoxFit.cover,
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                   if (_selectedPoliza != null) ...[
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Familiares:',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     FutureBuilder<List<dynamic>>(
//                       future: _futureFamiliares,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         } else if (snapshot.hasError) {
//                           return GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _futureFamiliares =
//                                     fetchFamiliares(_selectedPoliza['id']);
//                               });
//                             },
//                             child: const Center(
//                               child: Card(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(16.0),
//                                   child: Text(
//                                       'Problemas de conexión. Toca para reintentar'),
//                                 ),
//                               ),
//                             ),
//                           );
//                         } else if (!snapshot.hasData ||
//                             snapshot.data!.isEmpty) {
//                           return const Center(
//                             child: Card(
//                               child: Padding(
//                                 padding: EdgeInsets.all(16.0),
//                                 child: Text('No se encontraron familiares.'),
//                               ),
//                             ),
//                           );
//                         } else {
//                           final familiares = snapshot.data!;
//                           return Column(
//                             children: familiares.map<Widget>((familiar) {
//                               return Card(
//                                 clipBehavior: Clip.hardEdge,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ListTile(
//                                       title: Text(
//                                           '${familiar['nombres']} ${familiar['apellidos']}'),
//                                       subtitle: Text(
//                                           'Parentesco: ${familiar['parentesco']}'),
//                                     ),
//                                     if (familiar['urlImagen'] != null)
//                                       Image.network(
//                                         familiar['urlImagen'],
//                                         fit: BoxFit.cover,
//                                       ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                               'Correo: ${familiar['correoElectronico']}'),
//                                           Text(
//                                               'Teléfono: ${familiar['numeroTelefono']}'),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:avalon_app/app/presentation/bloc/app/app_bloc.dart';
import 'package:avalon_app/core/config/router/app_routes_pages.dart';
import 'package:avalon_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:avalon_app/features/shared/widgets/wid_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FamiliaresPage extends StatefulWidget {
  const FamiliaresPage({super.key});

  @override
  State<FamiliaresPage> createState() => _FamiliaresPageState();
}

class _FamiliaresPageState extends State<FamiliaresPage> {
  Future<List<dynamic>>? _futurePolizas;
  Future<List<dynamic>>? _futureFamiliares;
  dynamic _selectedPoliza;
  late String id;

  @override
  void initState() {
    final user = context.read<AppBloc>().state.user;
    id = user.id!.toString();
    super.initState();
    _futurePolizas = fetchPolizas();
  }

  Future<List<dynamic>> fetchPolizas() async {
    String url = 'http://149.56.110.32:8086/clientes/$id/clientesPolizas';
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

  Future<List<dynamic>> fetchFamiliares(int polizaId) async {
    final String url =
        'http://149.56.110.32:8086/clientesPolizas/$polizaId/cargasFamiliares';
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

  void _selectPoliza(dynamic poliza) {
    setState(() {
      _selectedPoliza = poliza;
      _futureFamiliares = fetchFamiliares(poliza['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Familiares'),
        elevation: 6,
      ),
      drawer: DrawerCustom(
        indexInitial: getDrawerOptionIndex(PAGES.formasPago.pageName),
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
                setState(() {
                  _futurePolizas = fetchPolizas();
                  _selectedPoliza = null;
                  _futureFamiliares = null;
                });
                refreshController
                  ..refreshCompleted()
                  ..loadComplete();
              },
              refreshController: refreshController,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(top: 10),
                children: [
                  ...polizas.map((poliza) {
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          _selectPoliza(poliza);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(poliza['poliza']['nombre']),
                              subtitle: Text(
                                'Aseguradora: ${poliza['poliza']['aseguradora']['nombre']}',
                              ),
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
                    );
                  }),
                  if (_selectedPoliza != null) ...[
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Familiares:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder<List<dynamic>>(
                      future: _futureFamiliares,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _futureFamiliares =
                                    fetchFamiliares(_selectedPoliza['id']);
                              });
                            },
                            child: const Center(
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                      'Problemas de conexión. Toca para reintentar'),
                                ),
                              ),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No se encontraron familiares.'),
                              ),
                            ),
                          );
                        } else {
                          final familiares = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: familiares.map<Widget>((familiar) {
                                return Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                            '${familiar['nombres']} ${familiar['apellidos']}'),
                                        subtitle: Text(
                                            'Parentesco: ${familiar['parentesco']}'),
                                      ),
                                      if (familiar['urlImagen'] != null)
                                        Image.network(
                                          familiar['urlImagen'],
                                          fit: BoxFit.cover,
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Correo: ${familiar['correoElectronico']}'),
                                            Text(
                                                'Teléfono: ${familiar['numeroTelefono']}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedPoliza != null
            ? () {
                if (_selectedPoliza != null) {
                  // context.go('/addFamiliar', extra: _selectedPoliza['id']);
                  context.pushNamed(PAGES.addFamiliar.pageName,
                      extra: _selectedPoliza['id']);
                }
              }
            : null,
        elevation: _selectedPoliza != null ? null : 0,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddFamiliarPage extends StatefulWidget {
  final int polizaId;

  const AddFamiliarPage({super.key, required this.polizaId});

  @override
  State<AddFamiliarPage> createState() => _AddFamiliarPageState();
}

class _AddFamiliarPageState extends State<AddFamiliarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _parentescoController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();

  Future<void> _addFamiliar() async {
    const String url =
        'http://149.56.110.32:8086/clientesPolizas/agregarFamiliar';
    const String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhdmFsb24iLCJpYXQiOjE3MTYyMTExNzgsImV4cCI6MTc0Nzc0NzE3OH0.rLk9oE1p0PJUGv8XZKgPNQJN0aDNuz0Gkr-IsNfGomzg1bv9-PTb40AIxCQJg2XXnMKSKfBUI-5bVI82pmBsWw';

    final dio = Dio();
    try {
      await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'polizaId': widget.polizaId,
          'nombres': _nombresController.text,
          'apellidos': _apellidosController.text,
          'parentesco': _parentescoController.text,
          'correoElectronico': _correoController.text,
          'numeroTelefono': _telefonoController.text,
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('Error adding familiar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al agregar familiar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Familiar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombresController,
                decoration: const InputDecoration(labelText: 'Nombres'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los nombres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(labelText: 'Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _parentescoController,
                decoration: const InputDecoration(labelText: 'Parentesco'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el parentesco';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _correoController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el correo electrónico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _telefonoController,
                decoration:
                    const InputDecoration(labelText: 'Número de Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addFamiliar();
                  }
                },
                child: const Text('Agregar Familiar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
