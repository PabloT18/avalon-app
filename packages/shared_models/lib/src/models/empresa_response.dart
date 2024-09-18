import 'dart:convert';

EmpresaResponse empresaResponseFromJson(String str) =>
    EmpresaResponse.fromJson(json.decode(str));

String empresaResponseToJson(EmpresaResponse data) =>
    json.encode(data.toJson());

class EmpresaResponse {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? descripcion;
  final String? correoElectronico;

  EmpresaResponse({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.descripcion,
    this.correoElectronico,
  });

  factory EmpresaResponse.fromJson(Map<String, dynamic> json) =>
      EmpresaResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        correoElectronico: json["correoElectronico"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "correoElectronico": correoElectronico,
      };
}
