// To parse this JSON data, do
//
//     final comentarioResponse = comentarioResponseFromJson(jsonString);

import 'dart:convert';

import 'package:shared_models/shared_models.dart';

List<ComentarioResponse> comentarioResponseFromJson(String str) =>
    List<ComentarioResponse>.from(
        json.decode(str).map((x) => ComentarioResponse.fromJson(x)));

String comentarioResponseToJson(List<ComentarioResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComentarioResponse extends Comentario {
  const ComentarioResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.contenido,
    super.usuarioComenta,
    super.imagenId,
    super.estado,
  });

  factory ComentarioResponse.fromJson(Map<String, dynamic> json) =>
      ComentarioResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        contenido: json["contenido"],
        usuarioComenta: json["usuarioComenta"] == null
            ? null
            : UserResponse.fromJson(json["usuarioComenta"]),
        imagenId: json["imagenId"],
        estado: json["estado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "contenido": contenido,
        "usuarioComenta": usuarioComenta?.toJson(),
        "imagenId": imagenId,
        "estado": estado,
      };
}
