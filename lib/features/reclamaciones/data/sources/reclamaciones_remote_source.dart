import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:avalon_app/features/reclamaciones/data/models/reclamaciones_response.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_models/shared_models.dart';

class ReclamacionesRemoteSource {
  Future<List<ReclamacionModel>> getReclamaciionesByCaseId(
      User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    String url;

    if (search == null) {
      url =
          '/reclamaciones?casoId=$casoId&page=$page&size=50&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/reclamaciones?casoId=$casoId&page=$page&size=50&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = ReclamacionResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<ReclamacionModel>> getreclamaciones(User user,
      {required int page, String? search}) async {
    String url;

    if (search == null) {
      url =
          '/reclamaciones?&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/reclamaciones?&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = ReclamacionResponse.fromJson(response.data);
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
      User user, int reclamcionId) async {
    String url = '/reclamaciones/$reclamcionId/comentarios';

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
    required int reclamcionId,
    required String comentario,
    File? image,
    required String nombreDocumento,
  }) async {
    String url = '/comentarios';

    // Build the comentario object
    Map<String, dynamic> comentarioData = {
      "reclamacionId": reclamcionId,
      "contenido": comentario,
      "usuarioComentaId": user.id,
      "estado": "A",
      "nombreDocumento": nombreDocumento,
    };

    // Prepare the FormData
    FormData formData = FormData();

    // Add the comentarioCitaMedica part with Content-Type application/json
    formData.files.add(
      MapEntry(
        'comentarioReclamacion',
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
          'fotoComentarioReclamacion',
          await MultipartFile.fromFile(
            image.path,
            filename: fileName,
            contentType:
                MediaType('image', lookupMimeType(image.path)!.split('/')[1]),
          ),
        ),
      );
    }

    try {
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

  Future<ReclamacionModel> crearReclamacion(
      User user, ReclamacionModel reclamacion, File? image,
      {required String nombreDocumento}) async {
    String url = '/reclamaciones';

    final Map<String, dynamic> requestData = reclamacion.toJsonCreate();
    final Map<String, dynamic> docuemntoName = {
      "nombreDocumento": nombreDocumento,
    };
    try {
      requestData.addEntries(docuemntoName.entries);
      FormData formData = FormData();

      // Add the comentarioCitaMedica part with Content-Type application/json
      formData.files.add(
        MapEntry(
          'reclamacion',
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
            'fotoReclamo',
            await MultipartFile.fromFile(
              image.path,
              filename: fileName,
              contentType: MediaType('image', fileType),
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
        final casoEntity = ReclamacionModel.fromJson(response.data);
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
