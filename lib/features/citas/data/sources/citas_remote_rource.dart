import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:avalon_app/core/config/remote/app_remote_config.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:shared_models/shared_models.dart';

import '../../domain/models/citas_response.dart';

class CitasRemoteSource {
  CitasRemoteSource();
  Future<List<CitaMedica>> getCitasByCaseId(User user, int casoId,
      {required int page, String? search, bool? update = false}) async {
    String url;

    if (search == null) {
      url =
          '/citasMedicas?casoId=$casoId&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/citasMedicas?casoId=$casoId&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = CitasMedicasResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<CitaMedica>> getCitas(User user,
      {required int page, String? search}) async {
    String url;

    if (search == null) {
      url =
          '/citasMedicas?&page=$page&size=5&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/citasMedicas?&page=$page&size=5&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
        final casosResponse = CitasMedicasResponse.fromJson(response.data);
        return casosResponse.data ?? [];
      } else {
        throw Exception('Error fetching data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data');
    }
  }

  Future<List<Comentario>> getComentariosById(User user, int citaId) async {
    String url = '/citasMedicas/$citaId/comentariosCitasMedicas';

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
    required int citaId,
    required String comentario,
    File? image,
    required String nombreDocumento,
  }) async {
    String url = '/comentariosCitasMedicas';

    // Build the comentario object
    Map<String, dynamic> comentarioData = {
      "citaMedicaId": citaId,
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
        'comentarioCitaMedica',
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
          'fotoComentarioCitaMedica',
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

  Future<CitaMedica> crearCita(
    User user,
    CitaMedica cita,
    File? image, {
    required String nombreDocumento,
  }) async {
    String url = '/citasMedicas';

    final Map<String, dynamic> requestData = cita.toJsonCreate();
    print(requestData);
    Map<String, dynamic> comentarioData = {
      "fechaTentativa": "2024-09-22",
      "ciudadPreferencia": "Cuenca",
      "padecimiento": "DESE APP",
      "informacionAdicional": "DESE APP",
      "otrosRequisitos": "fsa",
      "clientePolizaId": 1302,
      "casoId": 858,
      "requisitosAdicionales": {
        "VIAJES": false,
        "HOSPEDAJE": false,
        "SER_TRANSPORTE": false,
        "AMB_TERRESTRE": false,
        "AMB_AEREA": true,
        "SILLA_RUEDAS": false,
        "RECETA_MEDICA": false
      }
    };

    // Prepare the FormData
    FormData formData = FormData();

    // Add the comentarioCitaMedica part with Content-Type application/json
    formData.files.add(
      MapEntry(
        'citaMedica',
        MultipartFile.fromString(
          jsonEncode(requestData),
          contentType: MediaType('application', 'json'),
        ),
      ),
    );
    // If an image is provided, add it to the form data
    if (image != null) {
      String fileName = image.path.split('/').last;
      formData.files.add(
        MapEntry(
          'fotoCitaMedica',
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
        // Assuming the response is a single CasoEntity in JSON format
        final casoEntity = CitaMedica.fromJson(response.data);
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
