import 'dart:convert';
import 'dart:typed_data';
import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/features/citas/presentation/bloc/cita_detalle/cubit/comentario_nuev_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

class FullScreenImageFromId extends StatefulWidget {
  final int imageCode;
  final User user;

  const FullScreenImageFromId({
    super.key,
    required this.imageCode,
    required this.user,
  });

  @override
  _FullScreenImageFromIdState createState() => _FullScreenImageFromIdState();
}

class _FullScreenImageFromIdState extends State<FullScreenImageFromId> {
  Uint8List? _imageData;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchImageData();
  }

  Future<void> _fetchImageData() async {
    try {
      final Dio dio = Dio(BaseOptions(
        baseUrl: Environment.appProd
            ? Environment.pathAPIProd
            : Environment.pathAPIDev,
      ));
      Options? options = Options(
          headers: <String, String>{'authorization': widget.user.token!});
      final response = await dio.get(
        '/imagenes/${widget.imageCode}',
        options: options,
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData != null && jsonData['documento'] != null) {
          final decodedBytes = base64Decode(jsonData['documento']);
          setState(() {
            _imageData = decodedBytes;
            // _documentName = jsonData[
            //     'nombreDocumento']; // Asignamos el nombre del documento
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontró la imagen.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error al obtener la imagen: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener la imagen: $e';
        _isLoading = false;
      });
    }
  }

  void _showFullScreenImage(BuildContext context) {
    if (_imageData == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Cierra el diálogo al hacer tap.
            },
            child: InteractiveViewer(
              panEnabled: true, // Permite desplazar la imagen si está ampliada
              minScale: 0.5, // Escala mínima para el zoom
              maxScale: 4.0, // Escala máxima para el zoom
              child: Image.memory(
                _imageData!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage.isNotEmpty)
            Center(child: Text(_errorMessage))
          else if (_imageData != null)
            Container(
              constraints: const BoxConstraints(
                maxHeight: 150,
                // maxWidth: 250,
              ),
              child: GestureDetector(
                onTap: () {
                  // FocusScope.of(context).unfocus();
                  final cubit = context.read<ComentarioNuevCubit>();
                  cubit.textFieldFocusNode.unfocus();

                  _showFullScreenImage(context);
                },
                child: Image.memory(
                  _imageData!,
                  fit: BoxFit.contain,
                  // width: 150,
                  // height: 150,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
