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

  // static Future<Response> httpPost({
  //   required String url,
  //   required Map<String, dynamic> body,
  //   required Exception exception,
  //   String? credencialServicio,
  //   bool auth = true,
  // }) async {
  //   String basicAuth;
  //   Dio dio;
  //   if (Environment.apiMobsvc) {
  //     dio = dioMobsvc;
  //     basicAuth = 'Bearer $credencialServicio';
  //   } else {
  //     dio = Dio(BaseOptions(baseUrl: Environment.upsServerApiPro));
  //     basicAuth = 'Token $credencialServicio';
  //   }

  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: Environment.apiMobsvc ? body : FormData.fromMap(body),
  //       // data: FormData.fromMap(body),

  //       options: credencialServicio != null
  //           ? Options(headers: <String, String>{
  //               'authorization': basicAuth,
  //               HttpHeaders.contentTypeHeader: "multipart/form-data",
  //             })
  //           : null,
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
  //       return e.response!;
  //     } else if (e.response!.statusCode == 201) {
  //       return e.response!;
  //     } else {
  //       throw exception;
  //     }
  //   } catch (e) {
  //     throw exception;
  //   }
  // }

  // static Future<Response> httpPostJsonApp({
  //   required String url,
  //   required Map<String, dynamic> body,
  //   required Exception exception,
  //   String? credencialServicio,
  //   bool auth = true,
  // }) async {
  //   String basicAuth;
  //   Dio dio;
  //   if (Environment.apiMobsvc) {
  //     dio = dioMobsvc;
  //     basicAuth = 'Bearer $credencialServicio';
  //   } else {
  //     dio = Dio(BaseOptions(baseUrl: Environment.upsServerApiPro));
  //     basicAuth = 'Token $credencialServicio';
  //   }

  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: Environment.apiMobsvc ? body : FormData.fromMap(body),
  //       options: credencialServicio != null
  //           ? Options(headers: <String, String>{
  //               'authorization': basicAuth,
  //               HttpHeaders.contentTypeHeader: "application/json",
  //             })
  //           : null,
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
  //       return e.response!;
  //     } else if (e.response!.statusCode == 201) {
  //       return e.response!;
  //     } else {
  //       throw exception;
  //     }
  //   } catch (e) {
  //     throw exception;
  //   }
  // }

  // static Future<Response> httpPostBarrer({
  //   required String url,
  //   required Map<String, dynamic> body,
  //   required Exception exception,
  //   String? credencialServicio,
  //   bool auth = true,
  // }) async {
  //   // var dio = dioUPSapi;

  //   final dio = Dio();

  //   String basicAuth = 'Bearer $credencialServicio';

  //   try {
  //     final response = await dio.post(
  //       url,
  //       data: FormData.fromMap(body),
  //       options: credencialServicio != null
  //           ? Options(headers: <String, String>{
  //               'authorization': basicAuth,
  //               HttpHeaders.contentTypeHeader: "multipart/form-data",
  //             })
  //           : null,
  //     );

  //     return response;
  //   } on DioException catch (e) {
  //     if (e.response!.statusCode == 404 || e.response!.statusCode == 401) {
  //       return e.response!;
  //     } else if (e.response!.statusCode == 201) {
  //       return e.response!;
  //     } else {
  //       throw exception;
  //     }
  //   } catch (e) {
  //     throw exception;
  //   }
  // }
}
