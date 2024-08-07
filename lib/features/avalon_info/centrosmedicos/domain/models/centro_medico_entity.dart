import 'package:avalon_app/app/domain/entity/general_entities.dart';
import 'package:equatable/equatable.dart';

class CentroMedico extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? descripcion;
  final String? correoElectronico;
  final Direccion? direccion;

  const CentroMedico({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.descripcion,
    this.correoElectronico,
    this.direccion,
  });

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "correoElectronico": correoElectronico,
        "direccion": direccion?.toJson(),
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
        correoElectronico,
        direccion,
      ];
}
