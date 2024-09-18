import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cubit/comentario_nuev_cubit.dart';
import 'package:avalon_app/features/shared/functions/utils_functions.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ComentarioTextBox extends StatelessWidget {
  const ComentarioTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComentarioNuevCubit>();
    final TextEditingController messageController = TextEditingController();

    // final FocusNode textFieldFocusNode = FocusNode();
    return BlocBuilder<ComentarioNuevCubit, ComentarioNuevState>(
      builder: (context, state) {
        return FadeInUp(
          child: Column(
            children: [
              if (state is ComentarioImageSelected)
                Stack(
                  children: [
                    // Imagen seleccionada
                    GestureDetector(
                      onTap: () {
                        // Captura el focusNode antes de la operación asíncrona
                        // FocusScopeNode currentFocus = FocusScope.of(context);

                        // Quitar foco del TextField al abrir la imagen
                        // textFieldFocusNode.unfocus();

                        // Mostrar la imagen en pantalla completa
                        UtilsFunctionsViews.showFullScreenImage(
                          state.image,
                          context,
                        ); // Llamamos a la función para mostrar la imagen en un dialogo
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(state.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Botón de eliminar (X) en la esquina superior derecha
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<ComentarioNuevCubit>()
                              .removeImage(); // Llamada para eliminar la imagen
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Container(
                padding: const EdgeInsets.only(top: 4.0, bottom: 5, left: 8),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        maxLines:
                            3, // Hace que el TextField sea dinámico en líneas
                        minLines: 1, // Mínimo 1 línea
                        autocorrect: true,
                        // focusNode: textFieldFocusNode,
                        decoration: InputDecoration(
                          hintText: apptexts.appOptions.comentMessage,
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.photo),
                            onPressed: () => cubit.pickImage(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => cubit.sendComentario(
                        comentario: messageController.text,
                        image: (state is ComentarioImageSelected)
                            ? state.image
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
