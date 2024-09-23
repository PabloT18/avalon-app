import 'dart:convert';
import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_models/shared_models.dart';

class DetailPhoto extends StatefulWidget {
  const DetailPhoto({
    super.key,
    required this.imageCode,
    required this.user,
    this.title = true,
  });

  final int imageCode;
  final User user;
  final bool title;

  @override
  _DetailPhotoState createState() => _DetailPhotoState();
}

class _DetailPhotoState extends State<DetailPhoto> {
  Uint8List? _imageData;
  String? _documentName; // Guardamos el nombre del documento
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
            _documentName = jsonData[
                'nombreDocumento']; // Asignamos el nombre del documento
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

  void _showFullScreenImage() {
    if (_imageData == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Cierra el diálogo al hacer tap.
            },
            child: InteractiveViewer(
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
          if (widget.title) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  apptexts.citasPage.detalleFoto,
                ),
                // IconButton(
                //   icon: const Icon(Icons.save_alt),
                //   onPressed: _saveImage, // Guarda la imagen al hacer clic
                // ),
              ],
            ),
            const SizedBox(height: AppLayoutConst.spaceM),
          ],
          if (_isLoading)
            // const Center(child: CircularProgressIndicator())
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  onTap: () => _fetchImageData(),
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.photo,
                      size: 50,
                    ),
                  )),
            )
          else if (_errorMessage.isNotEmpty)
            // Center(child: Text(_errorMessage))
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                  onTap: () => _fetchImageData(),
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                    child: FaIcon(
                      FontAwesomeIcons.triangleExclamation,
                      size: 50,
                    ),
                  )),
            )
          else if (_imageData != null)
            FadeIn(
              child: GestureDetector(
                onTap: _showFullScreenImage,
                child: Image.memory(
                  _imageData!,
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
