import 'package:animate_do/animate_do.dart';
import 'package:avalon_app/features/reclamaciones/presentation/bloc/detalle/bloc/reclamcaion_detalle_bloc.dart';

import 'package:avalon_app/features/shared/functions/fun_views.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detalle/comentario_nuev_cubit.dart';

class ComentarioTextBox extends StatelessWidget {
  const ComentarioTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComentarioNuevCubit>();
    final TextEditingController messageController = TextEditingController();

    return BlocConsumer<ComentarioNuevCubit, ComentarioNuevState>(
      listener: (context, state) {
        if (state is ComentarioError) {
          UtilsFunctionsViews.showFlushBar(
            message: state.message,
          ).show(context);
        }
        if (state is ComentarioSent) {
          messageController.clear();
          context
              .read<ReclamacionDetalleBloc>()
              .add(const GetReclamacionHistorial());
        }
      },
      builder: (context, state) {
        return FadeInUp(
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                if (state is ComentarioImageSelected)
                  Stack(
                    children: [
                      // Imagen seleccionada
                      GestureDetector(
                        onTap: () {
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
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          focusNode: cubit.textFieldFocusNode,
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
                        onPressed: state is ComentarioSending
                            ? null
                            : () {
                                if (messageController.text.isEmpty) return;

                                final cubit =
                                    context.read<ComentarioNuevCubit>();
                                cubit.textFieldFocusNode.unfocus();
                                cubit.sendComentario(
                                  comentario: messageController.text,
                                  image: (state is ComentarioImageSelected)
                                      ? state.image
                                      : null,
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
