import 'package:equatable/equatable.dart';

class Especialidad extends Equatable {
  final DateTime? createdBy;
  final DateTime? createdDate;
  final DateTime? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombre;
  final String? descripcion;

  const Especialidad({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombre,
    this.descripcion,
  });

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate,
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
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
      ];
}
