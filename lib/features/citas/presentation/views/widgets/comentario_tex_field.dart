import 'package:avalon_app/core/config/responsive/responsive_class.dart';
import 'package:avalon_app/core/config/theme/app_colors.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cita_detalle_bloc.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cubit/comentario_nuev_cubit.dart';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:avalon_app/features/shared/functions/utils_functions.dart';

import 'package:avalon_app/i18n/generated/translations.g.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ComentarioCitaTextBox extends StatelessWidget {
  const ComentarioCitaTextBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComentarioNuevCubit>();
    final TextEditingController messageController = TextEditingController();
    final responsive = ResponsiveCustom.of(context);
    return BlocConsumer<ComentarioNuevCubit, ComentarioNuevState>(
      listener: (context, state) {
        if (state is ComentarioError) {
          UtilsFunctionsViews.showFlushBar(
            message: state.message,
          ).show(context);
        }
        if (state is ComentarioSent) {
          messageController.clear();
          context.read<CitaDetalleBloc>().add(const GetCitaHistorial());
        }
      },
      builder: (context, state) {
        return FadeInUp(
          child: Container(
            // color: Colors.white,
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
                if (state is ComentarioPDFSelected)
                  Stack(
                    children: [
                      // Imagen seleccionada
                      SizedBox(
                        width: responsive.wp(50),
                        child: Card(
                          margin: const EdgeInsets.all(8.0),

                          // width: 150,
                          // height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.picture_as_pdf,
                                  color: Colors.red, size: 40),
                              const SizedBox(width: 20),
                              // Muestra el nombre del PDF, si existe
                              Text(
                                state.pdf.path.split('/').last,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
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
                  padding: const EdgeInsets.only(top: 4.0, left: 8),
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    children: [
                      // Caja con borde y el TextField adentro
                      Expanded(
                        child: Container(
                          // Bordes y color (si quieres)
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.secondaryBlue),
                          ),
                          // padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: messageController,
                                  focusNode: cubit.textFieldFocusNode,
                                  minLines: 1,
                                  maxLines: 3, // Hasta 3 líneas3
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    hintText: apptexts.appOptions.comentMessage,
                                    border:
                                        InputBorder.none, // Sin borde interno
                                    //  border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.photo),
                                onPressed: () => cubit.pickImage(),
                              ),

                              // Ícono "archivo" (si deseas)
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () => cubit.onPdfSelected(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (messageController.text.isEmpty) return;

                          final cubit = context.read<ComentarioNuevCubit>();
                          cubit.textFieldFocusNode.unfocus();
                          cubit.sendComentario(
                            comentario: messageController.text,
                            image: (state is ComentarioImageSelected)
                                ? state.image
                                : null,
                            pdf: (state is ComentarioPDFSelected)
                                ? state.pdf
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
