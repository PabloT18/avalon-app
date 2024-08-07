import 'dart:convert';

List<MetodoPago> metodoPagoFromJson(String str) =>
    List<MetodoPago>.from(json.decode(str).map((x) => MetodoPago.fromJson(x)));

String metodoPagoToJson(List<MetodoPago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MetodoPago {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? descripcion;

  MetodoPago({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.descripcion,
  });

  factory MetodoPago.fromJson(Map<String, dynamic> json) => MetodoPago(
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
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
