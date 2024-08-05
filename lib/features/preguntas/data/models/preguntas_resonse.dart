import 'dart:convert';

List<PreguntaResponse> preguntaResponseFromJson(String str) =>
    List<PreguntaResponse>.from(
        json.decode(str).map((x) => PreguntaResponse.fromJson(x)));

String preguntaResponseToJson(List<PreguntaResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreguntaResponse {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? contenido;
  final String? respuesta;
  final int? nivel;
  final dynamic padre;

  PreguntaResponse({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.contenido,
    this.respuesta,
    this.nivel,
    this.padre,
  });

  factory PreguntaResponse.fromJson(Map<String, dynamic> json) =>
      PreguntaResponse(
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
        respuesta: json["respuesta"],
        nivel: json["nivel"],
        padre: json["padre"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "contenido": contenido,
        "respuesta": respuesta,
        "nivel": nivel,
        "padre": padre,
      };
}
