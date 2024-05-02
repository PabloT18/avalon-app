import 'package:alumni_app/core/config/responsive/responsive.dart';
import 'package:alumni_app/core/config/router/app_routes_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../../../shared/widgets/wid_app_bar.dart';
import '../../domain/models/reserva_option_model.dart';

class ReservasPage extends StatelessWidget {
  const ReservasPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    List<ReservaOption> reservaOptions = [
      ReservaOption(
        title: 'Coliseo',
        icon: AppAssets.iconRcoliseo,
      ),
      ReservaOption(
        title: 'CANCHA SINTÉTICA 1',
        icon: AppAssets.iconRfutbol,
      ),
      ReservaOption(
        title: 'CANCHA SINTÉTICA 2',
        icon: AppAssets.iconRfutbol,
      ),
      ReservaOption(
        title: 'CANCHA BÁSKET',
        icon: AppAssets.iconRbasket,
      ),
      ReservaOption(
        title: 'CANCHA SINTÉTICA VOLLEY',
        icon: AppAssets.iconRvolley,
      ),
      ReservaOption(
        title: 'ESTADIO',
        icon: AppAssets.iconRestadio,
      ),
      ReservaOption(
        title: 'CANCHA TENIS 1',
        icon: AppAssets.iconRtenis,
      ),
      ReservaOption(
        title: 'CANCHA TENIS 2',
        icon: AppAssets.iconRtenis,
      ),
      ReservaOption(
        title: 'CANCHA VOLLEY',
        icon: AppAssets.iconRvolley,
      ),
      ReservaOption(
        title: 'GIMNASIO',
        icon: AppAssets.iconRgym,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarCustom(
        title: title,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppLayoutConst.paddingXL),
        child: Column(
          children: [
            Text(
              'Puedes utilizar las instalaciones deportivas haciendo tu reserva aqui:',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppLayoutConst.spaceL),
            Expanded(
              child: ListView.builder(
                itemCount: reservaOptions.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    margin:
                        const EdgeInsets.only(bottom: AppLayoutConst.spaceL),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        String nombre = "Francisco";

                        bool? resultado = await mostrarDialogoOpciones(
                            context, 'nombre', reservaOptions[index].title);
                        if (resultado ?? false) {
                          print("El usuario seleccionó 'Enviar'");
                          // Puedes agregar más lógica aquí si el usuario selecciona 'Enviar'
                        } else {
                          print("El usuario seleccionó 'Cancelar'");
                          // O manejar la lógica si el usuario selecciona 'Cancelar'
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Image.asset(
                        reservaOptions[index].icon,
                        height: 25,
                      ),
                      label: Text(
                        reservaOptions[index].title.toUpperCase(),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> mostrarDialogoOpciones(
      BuildContext context, String nombre, String opcion) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Confirmación'),
          content: Text(
              'Hola $nombre, ¿quieres enviar esta opción: "$opcion"?\nSe le contactara por los canales oficiales de la institución'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Devuelve 'false' al cerrar el diálogo
              },
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Devuelve 'true' al cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
