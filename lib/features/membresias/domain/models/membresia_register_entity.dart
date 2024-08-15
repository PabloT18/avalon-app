import 'package:avalon_app/features/membresias/domain/models/cliente_membresia_entity.dart';
import 'package:equatable/equatable.dart';

import 'asesor_entity.dart';
import 'membresia_entity.dart';

class MembresiaRegister extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final Membresia? membresia;
  final ClienteMembresia? cliente;
  final AsesorMembresia? asesor;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String? estado;

  const MembresiaRegister({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.membresia,
    this.cliente,
    this.asesor,
    this.fechaInicio,
    this.fechaFin,
    this.estado,
  });

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "membresia": membresia?.toJson(),
        "cliente": cliente?.toJson(),
        "asesor": asesor?.toJson(),
        "fechaInicio": fechaInicio?.toIso8601String(),
        "fechaFin": fechaFin?.toIso8601String(),
        "estado": estado,
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        membresia,
        cliente,
        asesor,
        fechaInicio,
        fechaFin,
        estado,
      ];
}
