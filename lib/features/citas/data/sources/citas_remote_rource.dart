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
          '/citasMedicas?casoId=$casoId&page=$page&size=50&sortField=createdDate&sortOrder=desc';
    } else {
      url =
          '/citasMedicas?casoId=$casoId&page=$page&size=50&busqueda=$search&sortField=createdDate&sortOrder=desc';
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
      throw Exception('Error fetching data');
    }
  }

  Future<void> sendComentario({
    required User user,
    required int citaId,
    required String comentario,
    File? image,
    File? pdf,
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
      "tipoDocumento": pdf != null ? "PDF" : "IMAGEN",
    };

    // Prepare the FormData
    FormData formData = FormData();
    try {
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
      // PDF (opcional)
      if (pdf != null) {
        // Por ejemplo, si quieres llamarlo 'pdfEmergencia':
        final String pdfName = nombreDocumento.replaceAll('.jpg', '.pdf');
        // O ajusta para que sea algo más dinámico

        formData.files.add(
          MapEntry(
            'fotoComentarioCitaMedica',
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
      throw Exception('Error sending comentario');
    }
  }

  Future<CitaMedica> crearCita(
    User user,
    CitaMedica cita,
    File? image,
    File? pdf, // Nuevo parámetro para PDF

    {
    required String nombreDocumento,
  }) async {
    String url = '/citasMedicas';

    final Map<String, dynamic> requestData = cita.toJsonCreate();

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
    // If an image is provided, add it to the form data
    if (image != null) {
      String fileName = nombreDocumento;

      String fileType = nombreDocumento.split('.').last;

      formData.files.add(
        MapEntry(
          'fotoCitaMedica',
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
          'fotoCitaMedica',
          await MultipartFile.fromFile(
            pdf.path,
            filename: pdfName,
            contentType: MediaType('application', 'pdf'),
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
        throw Exception('Error al crear el cita medica');
      }
    } catch (e) {
      throw Exception('Error creando cita medica');
    }
  }
}
