import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:animate_do/animate_do.dart';
import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
import 'package:avalon_app/features/shared/widgets/loaders/loaders_widgets.dart';
import 'package:avalon_app/i18n/generated/translations.g.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:shared_models/shared_models.dart';

class DetailPhotoFile extends StatefulWidget {
  const DetailPhotoFile({
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

class _DetailPhotoState extends State<DetailPhotoFile> {
  // Uint8List? _imageData;
  // String? _documentName; // Guardamos el nombre del documento
  // bool _isLoading = true;
  // String _errorMessage = '';

  /// Datos (base64 -> bytes) del documento (sea imagen o PDF)
  Uint8List? _documentData;

  /// Nombre del archivo/documento (ej: "1234.pdf" o "foto.png")
  String? _documentName;

  /// Tipo del documento devuelto por el servicio (ej: "PDF", "IMAGEN")
  String? _documentType;

  final CancelToken _cancelToken = CancelToken();

  bool _isLoading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _fetchImageData();
  }

  @override
  void dispose() {
    _cancelToken.cancel("Widget disposed");
    super.dispose();
  }

  Future<void> _fetchImageData() async {
    try {
      final Dio dio = Dio(BaseOptions(
        baseUrl: Environment.appProd
            ? Environment.pathAPIProd
            : Environment.pathAPIDev,
      ));
      Options options = Options(headers: {
        'authorization': widget.user.token!,
      });

      final response = await dio.get(
        '/imagenes/${widget.imageCode}',
        options: options,
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData != null && jsonData['documento'] != null) {
          // Convertimos el base64 en bytes
          final decodedBytes = base64Decode(jsonData['documento']);

          setState(() {
            _documentData = decodedBytes;
            _documentName = jsonData['nombreDocumento'];
            _documentType = jsonData['tipo']?.toUpperCase() ?? 'IMAGEN';
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontró el documento.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener el documento: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        print('Llamada cancelada porque el widget se dispose');
        return;
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener el documento: $e';
        _isLoading = false;
      });
    }
  }

  /// Muestra la imagen en un diálogo de pantalla completa
  void _showFullScreenImage() {
    if (_documentData == null) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              child: Image.memory(
                _documentData!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Ejemplo de método para abrir un PDF en pantalla completa
  /// Requiere un paquete para ver PDFs, por ejemplo `syncfusion_flutter_pdfviewer`
  /// o alguno similar.
  void _showFullScreenPdf() async {
    if (_documentData == null) return;

    // Un ejemplo usando la librería syncfusion_flutter_pdfviewer.
    try {
      // 1. Obtenemos un directorio temporal (o documentsDirectory)
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${_documentName ?? 'document.pdf'}';

      // 2. Guardamos los bytes en un archivo PDF
      final file = File(filePath);
      await file.writeAsBytes(_documentData!, flush: true);

      // 3. Navegamos a la pantalla donde se mostrará el PDF con flutter_pdfview
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PDFViewerScreen(filePath: file.path),
        ),
      );
    } catch (e) {
      debugPrint('Error abriendo PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Can not read PDF.')),
      );
    }
    // O podrías navegar a otra pantalla que tenga un PdfViewer:
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => PdfViewScreen(
    //       pdfData: _documentData!,
    //       title: _documentName ?? 'Documento PDF',
    //     ),
    //   ),
    // );

    // Por simplicidad, aquí solo mostramos un SnackBar:
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = _documentType == 'PDF';

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
                  apptexts.appOptions.attachments(n: 1),
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
                      child: CircularProgressIndicatorCustom())),
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
          // 3. Documento Ok: ver si es PDF o Imagen
          else if (_documentData != null)
            isPdf ? _buildPdfWidget() : _buildImageWidget(),
          // else if (_imageData != null)
          //   FadeIn(
          //     child: GestureDetector(
          //       onTap: _showFullScreenImage,
          //       child: Image.memory(
          //         _imageData!,
          //         fit: BoxFit.contain,
          //         width: 150,
          //         height: 150,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  /// Construye la vista para PDF
  Widget _buildPdfWidget() {
    return FadeIn(
      child: GestureDetector(
        onTap: _showFullScreenPdf, // Abre PDF en fullscreen (o lo que quieras)
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Container(
            color: Colors.grey.shade200,
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                // Muestra el nombre del PDF, si existe
                Text(
                  _documentName ?? 'Documento PDF',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construye la vista para IMAGEN
  Widget _buildImageWidget() {
    return FadeIn(
      child: GestureDetector(
        onTap: _showFullScreenImage,
        child: Image.memory(
          _documentData!,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String filePath;

  const PDFViewerScreen({super.key, required this.filePath});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  int? _totalPages = 0;
  final int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.filePath,
            enableSwipe: true,
            swipeHorizontal: false,
            // Espaciado automático entre páginas
            autoSpacing: true,
            // Efecto de rebote al pasar página
            pageFling: true,
            onRender: (pages) {
              setState(() {
                _totalPages = pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            // onPageChanged: (int page, int total) {
            //   setState(() {
            //     _currentPage = page;
            //   });
            // },
          ),
          // Muestra un loader mientras el PDF se renderiza
          if (!pdfReady) const Center(child: CircularProgressIndicator()),
        ],
      ),
      // Ejemplo de botón para pasar a la siguiente página
      // floatingActionButton:
      //     (_totalPages != null && _currentPage + 1 < _totalPages!)
      //         ? FloatingActionButton(
      //             child: const Icon(Icons.chevron_right),
      //             onPressed: () async {
      //               await _pdfViewController?.setPage(_currentPage + 1);
      //             },
      //           )
      //         : null,
    );
  }
}
