// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:avalon_app/app/data/sources/local/enviroment.dart';
// import 'package:avalon_app/core/config/responsive/responsive_layouts.dart';
// import 'package:avalon_app/i18n/generated/translations.g.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_models/shared_models.dart';

// class DetailPhoto extends StatefulWidget {
//   const DetailPhoto({
//     super.key,
//     required this.imageCode,
//     required this.user,
//   });

//   final int imageCode;
//   final User user;

//   @override
//   _DetailPhotoState createState() => _DetailPhotoState();
// }

// class _DetailPhotoState extends State<DetailPhoto> {
//   Uint8List? _imageData;
//   String? _documentName; // Guardamos el nombre del documento
//   bool _isLoading = true;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchImageData();
//   }

//   Future<void> _fetchImageData() async {
//     try {
//       final Dio dio = Dio(BaseOptions(
//         baseUrl: Environment.appProd
//             ? Environment.pathAPIProd
//             : Environment.pathAPIDev,
//       ));
//       Options? options = Options(
//           headers: <String, String>{'authorization': widget.user.token!});
//       final response = await dio.get(
//         '/imagenes/${widget.imageCode}',
//         options: options,
//       );

//       if (response.statusCode == 200) {
//         final jsonData = response.data;

//         if (jsonData != null && jsonData['documento'] != null) {
//           final decodedBytes = base64Decode(jsonData['documento']);
//           setState(() {
//             _imageData = decodedBytes;
//             _documentName = jsonData[
//                 'nombreDocumento']; // Asignamos el nombre del documento
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _errorMessage = 'No se encontró la imagen.';
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _errorMessage = 'Error al obtener la imagen: ${response.statusCode}';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Error al obtener la imagen: $e';
//         _isLoading = false;
//       });
//     }
//   }

//   void _showFullScreenImage() {
//     if (_imageData == null) return;

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop(); // Cierra el diálogo al hacer tap.
//             },
//             child: InteractiveViewer(
//               child: Image.memory(
//                 _imageData!,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _saveImage() async {
//     if (_imageData == null || _documentName == null) return;

//     // Solicita permisos para acceder al almacenamiento
//     if (await _requestPermission(Permission.storage)) {
//       // Guarda la imagen en la galería usando el nombre del documento
//       final result = await ImageGallerySaver.saveImage(
//         _imageData!,
//         quality: 100,
//         name: _documentName!, // Utiliza el nombre del documento
//       );

//       if (result['isSuccess']) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Imagen guardada en la galería")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Error al guardar la imagen")),
//         );
//       }
//     }
//   }

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       final status = await permission.request();
//       return status == PermissionStatus.granted;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 apptexts.citasPage.detalleFoto,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.save_alt),
//                 onPressed: _saveImage, // Guarda la imagen al hacer clic
//               ),
//             ],
//           ),
//           const SizedBox(height: AppLayoutConst.spaceM),
//           if (_isLoading)
//             const Center(child: CircularProgressIndicator())
//           else if (_errorMessage.isNotEmpty)
//             Center(child: Text(_errorMessage))
//           else if (_imageData != null)
//             GestureDetector(
//               onTap: _showFullScreenImage,
//               child: Image.memory(
//                 _imageData!,
//                 fit: BoxFit.contain,
//                 width: 150,
//                 height: 150,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
