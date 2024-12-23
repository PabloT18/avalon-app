import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/emergencias/data/models/emergencias_response.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:shared_models/shared_models.dart';

class EmergenciasRemoteSource {
  EmergenciasRemoteSource();
  Future<List<EmergenciaModel>> getEmergenciasByCaseId(User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    String url;

    if (search == null) {
      url =
          '/emergencias?casoId=$casoId&page=$page&size=50&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/emergencias?casoId=$casoId&page=$page&size=50&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final casosResponse = EmergenciaResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<EmergenciaModel>> getEmergencias(User user,
      {required int page, String? search}) async {
    String url;

    if (search == null) {
      url =
          '/emergencias?&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/emergencias?&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
    }

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final casosResponse = EmergenciaResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<Comentario>> getComentariosById(
      User user, int emergenciaId) async {
    String url = '/emergencias/$emergenciaId/comentariosEmergencias';

    try {
      // Utiliza el método httpGet de APPRemoteConfig
      final response = await APPRemoteConfig.httpGet(
        url: url,
        exception: Exception('Error fetching data'),
        token: user.token!,
      );

      // Verifica el statusCode directamente en el response
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        return jsonResponse
            .map((data) => ComentarioResponse.fromJson(data))
            .toList();
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<void> sendComentario({
    required User user,
    required int emergenciaId,
    required String comentario,
    File? image,
    File? pdf,
    required String nombreDocumento,
  }) async {
    String url = '/comentariosEmergencias';

    // Build the comentario object
    Map<String, dynamic> comentarioData = {
      "emergenciaId": emergenciaId,
      "contenido": comentario,
      "usuarioComentaId": user.id,
      "estado": "A",
      "nombreDocumento": nombreDocumento,
      "tipoDocumento": pdf != null ? "PDF" : "IMAGEN",
    };

    // Prepare the FormData
    FormData formData = FormData();
    try {
      // Add the comentarioCitaMedica part with Content-Type application/json
      formData.files.add(
        MapEntry(
          'comentarioEmergencia',
          MultipartFile.fromString(
            jsonEncode(comentarioData),
            contentType: MediaType('application', 'json'),
          ),
        ),
      );

      // If an image is provided, add it to the form data
      if (image != null) {
        String fileName = image.path.split('/').last;
        formData.files.add(
          MapEntry(
            'fotoComentarioEmergencia',
            await MultipartFile.fromFile(
              image.path,
              filename: fileName,
              contentType:
                  MediaType('image', lookupMimeType(image.path)!.split('/')[1]),
            ),
          ),
        );
      }

      // PDF (opcional)
      if (pdf != null) {
        // Por ejemplo, si quieres llamarlo 'pdfEmergencia':
        final String pdfName = nombreDocumento.replaceAll('.jpg', '.pdf');
        // O ajusta para que sea algo más dinámico

        formData.files.add(
          MapEntry(
            'fotoComentarioEmergencia',
            await MultipartFile.fromFile(
              pdf.path,
              filename: pdfName,
              contentType: MediaType('application', 'pdf'),
            ),
          ),
        );
      }

      final response = await APPRemoteConfig.httpPost(
        url: url,
        data: formData,
        token: user.token!,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success
        log('Comentario enviado con éxito');
      } else {
        // Handle error
        throw Exception('Error al enviar el comentario');
      }
    } catch (e) {
      print('Error sending comentario: $e');
      throw Exception('Error sending comentario');
    }
  }

  Future<EmergenciaModel> crearEmergencia(User user, EmergenciaModel emergencia,
      File? image, File? pdf, // Nuevo parámetro para PDF
      {required String nombreDocumento}) async {
    String url = '/emergencias';

    final Map<String, dynamic> requestData = emergencia.toJsonCreate();
    final Map<String, dynamic> docuemntoName = {
      "nombreDocumento": nombreDocumento,
    };
    final Map<String, dynamic> tipoDocumento = {
      "tipoDocumento": pdf != null ? "PDF" : "IMAGEN",
    };

    requestData.addEntries(docuemntoName.entries);
    requestData.addEntries(tipoDocumento.entries);
    // Prepare the FormData
    FormData formData = FormData();
    try {
      // Add the comentarioCitaMedica part with Content-Type application/json
      formData.files.add(
        MapEntry(
          'emergencia',
          MultipartFile.fromString(
            jsonEncode(requestData),
            contentType: MediaType('application', 'json'),
          ),
        ),
      );
      // If an image is provided, add it to the form data
      if (image != null) {
        String fileName = nombreDocumento;

        String fileType = nombreDocumento.split('.').last;

        formData.files.add(
          MapEntry(
            'fotoEmergencia',
            await MultipartFile.fromFile(
              image.path,
              filename: fileName,
              contentType: MediaType('image', fileType),
            ),
          ),
        );
      }

      // PDF (opcional)
      if (pdf != null) {
        // Por ejemplo, si quieres llamarlo 'pdfEmergencia':
        final String pdfName = nombreDocumento.replaceAll('.jpg', '.pdf');
        // O ajusta para que sea algo más dinámico

        formData.files.add(
          MapEntry(
            'fotoEmergencia',
            await MultipartFile.fromFile(
              pdf.path,
              filename: pdfName,
              contentType: MediaType('application', 'pdf'),
            ),
          ),
        );
      }

      final response = await APPRemoteConfig.httpPost(
        url: url,
        data: formData,
        token: user.token!,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Assuming the response is a single CasoEntity in JSON format
        final casoEntity = EmergenciaModel.fromJson(response.data);
        return casoEntity;
      } else {
        throw Exception('Error al crear el caso');
      }
    } catch (e) {
      print('Error creando caso: $e');
      throw Exception('Error creando caso');
    }
  }
}
