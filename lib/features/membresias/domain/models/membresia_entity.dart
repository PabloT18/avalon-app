import 'package:equatable/equatable.dart';

class Membresia extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? nombres;
  final String? detalle;
  final String? estado;
  final int? vigenciaMeses;

  const Membresia({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.nombres,
    this.detalle,
    this.estado,
    this.vigenciaMeses,
  });

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombres": nombres,
        "detalle": detalle,
        "estado": estado,
        "vigenciaMeses": vigenciaMeses,
      };
  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        nombres,
        detalle,
        estado,
        vigenciaMeses,
      ];
}
