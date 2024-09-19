import 'dart:developer';
import 'dart:io';

import 'package:avalon_app/app/data/sources/local/enviroment.dart';
import 'package:avalon_app/core/error/erros.dart';
import 'package:dio/dio.dart';

class APPRemoteConfig {
  static final dioApp = Dio(BaseOptions(
    baseUrl:
        Environment.appProd ? Environment.pathAPIProd : Environment.pathAPIDev,
  ));

  static Future<Response> httpGet({
    required String url,
    required Exception exception,
    required String token,
  }) async {
    Options? options =
        Options(headers: <String, String>{'authorization': token});

    try {
      final response = await dioApp.get(url, options: options);

      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw InternetAccessException();
      }
      // if(e.error is FormatException)
      if (e.response == null) {
        throw exception;
      }
      if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
        return e.response!;
      } else if (e.response!.statusCode == 201) {
        return e.response!;
      } else if (e.error is SocketException) {
        throw exception;
      } else {
        throw exception;
      }
    } on SocketException catch (e) {
      log('APP Services GET error-> Error de conexión: $e');
      throw exception;
    } catch (e) {
      log('APP Services GET errore-> $e');
      throw exception;
    }
  }

  static Future<Response> httpPut({
    required String url,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    Options? options =
        Options(headers: <String, String>{'authorization': token});

    try {
      final response = await dioApp.put(url, data: data, options: options);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw InternetAccessException();
      }

      if (e.response == null) {
        throw Exception('Failed to update data');
      }

      if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
        return e.response!;
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      log('APP Services PUT error: $e');
      throw Exception('Failed to update data');
    }
  }

// Aquí está el nuevo método POST
  static Future<Response> httpPost({
    required String url,
    required dynamic data, // Puede ser un Map<String, dynamic> o FormData
    required String token,
    bool isMultipart = false, // Si es true, se usará multipart/form-data
  }) async {
    Options options = Options(
      headers: <String, String>{
        'authorization': token,
        'Content-Type': 'application/json',
      },
    );

    try {
      final response = await dioApp.post(url, data: data, options: options);
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw InternetAccessException();
      }
      if (e.response == null) {
        throw Exception('Failed to post data');
      }
      if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
        return e.response!;
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      log('APP Services POST error: $e');
      throw Exception('Failed to post data');
    }
  }
}
