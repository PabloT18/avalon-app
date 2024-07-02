// import 'package:alumni_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
// import 'package:flutter/material.dart';

// import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ComunicadosPage extends StatelessWidget {
//   const ComunicadosPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final refreshController = RefreshController(initialRefresh: false);

//     return SmartRefrehsCustom(
//       key: const Key('__noticias_list_key__'),
//       onRefresh: () async {
//         await Future.delayed(const Duration(seconds: 1));
//         refreshController
//           ..refreshCompleted()
//           ..loadComplete();
//       },
//       refreshController: refreshController,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Card(
//             clipBehavior: Clip.hardEdge,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text('AvalonPlus Noti'),
//                   subtitle: const Text('Prueba de mensaje como notificación'),
//                   onTap: () {
//                     // AppRouter.goToLogin();
//                   },
//                 ),
//                 Image.network(
//                     'https://avalonplus.com/wp-content/uploads/2023/12/avalon.png',
//                     fit: BoxFit.cover)
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Divider(),
//           ),
//           Card(
//             clipBehavior: Clip.hardEdge,
//             child: Column(
//               children: [
//                 ListTile(
//                   title: const Text('AvalonPlus Noti'),
//                   subtitle: const Text(
//                       'Prueba de mensaje como notificación sin imagen'),
//                   onTap: () {
//                     // AppRouter.goToLogin();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:alumni_app/features/shared/widgets/refresher/smart_refresh_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:alumni_app/features/shared/widgets/wid_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComunicadosPage extends StatefulWidget {
  const ComunicadosPage({super.key});

  @override
  // _ComunicadosPageState createState() => _ComunicadosPageState();
  State<ComunicadosPage> createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  Future<List<dynamic>>? _futureNotificaciones;

  @override
  void initState() {
    super.initState();
    _futureNotificaciones = fetchNotificaciones();
  }

  Future<List<dynamic>> fetchNotificaciones() async {
    const String url = 'http://149.56.110.32:8087/notificaciones';
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

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: false);

    return FutureBuilder<List<dynamic>>(
      future: _futureNotificaciones,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _futureNotificaciones = fetchNotificaciones();
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
                _futureNotificaciones = fetchNotificaciones();
              });
            },
            child: const Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                      'No se encontraron notificaciones. Toca para reintentar'),
                ),
              ),
            ),
          );
        } else {
          final notificaciones = snapshot.data!;
          return SmartRefrehsCustom(
            key: const Key('__noticias_list_key__'),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                _futureNotificaciones = fetchNotificaciones();
              });
              refreshController
                ..refreshCompleted()
                ..loadComplete();
            },
            refreshController: refreshController,
            child: ListView.builder(
              itemCount: notificaciones.length,
              itemBuilder: (context, index) {
                final notificacion = notificaciones[index];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(notificacion['asunto']),
                        subtitle: Text(notificacion['mensaje']),
                        leading: const CircleAvatar(
                            backgroundImage: AssetImage(AppAssets.isotipo1)),
                        onTap: () {
                          // _showNotificacionDetails(context, notificacion);
                        },
                      ),
                      // if (notificacion['tipoNotificacion']['descripcion'] !=
                      //     null)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       'Tipo: ${notificacion['tipoNotificacion']['descripcion']}',
                      //       style: const TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  void _showNotificacionDetails(BuildContext context, dynamic notificacion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(notificacion['asunto']),
          scrollable: true,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Mensaje: ${notificacion['mensaje']}'),
                Text('Enviado por: ${notificacion['usuarioEnvia']}'),
                Text('Respuesta: ${notificacion['respuesta']}'),
                Text(
                    'Tipo: ${notificacion['tipoNotificacion']['descripcion']}'),
              ],
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
}
