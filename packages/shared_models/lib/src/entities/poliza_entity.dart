import 'package:equatable/equatable.dart';

import 'aseguradora_entity.dart';

class Poliza extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? descripcion;
  final String? estado;
  final int? vigenciaMeses;
  final Aseguradora? aseguradora;

  const Poliza({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.descripcion,
    this.estado,
    this.vigenciaMeses,
    this.aseguradora,
  });

  factory Poliza.fromJson(Map<String, dynamic> json) => Poliza(
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
        estado: json["estado"],
        vigenciaMeses: json["vigenciaMeses"],
        aseguradora: json["aseguradora"] == null
            ? null
            : Aseguradora.fromJson(json["aseguradora"]),
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "vigenciaMeses": vigenciaMeses,
        "aseguradora": aseguradora?.toJson(),
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        nombre,
        descripcion,
        estado,
        vigenciaMeses,
        aseguradora,
      ];
}
