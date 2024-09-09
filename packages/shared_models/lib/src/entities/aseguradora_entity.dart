import 'package:equatable/equatable.dart';

class Aseguradora extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? correoElectronico;
  final String? estado;

  const Aseguradora({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.correoElectronico,
    this.estado,
  });

  factory Aseguradora.fromJson(Map<String, dynamic> json) => Aseguradora(
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
        correoElectronico: json["correoElectronico"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "correoElectronico": correoElectronico,
        "estado": estado,
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        nombre,
        correoElectronico,
        estado,
      ];
}
