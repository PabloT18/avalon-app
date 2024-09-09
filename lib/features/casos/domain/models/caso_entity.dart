import 'package:equatable/equatable.dart';
import 'package:shared_models/shared_models.dart';

class CasoEntity extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? codigo;
  final String? observaciones;
  final ClientePoliza? clientePoliza;
  final String? displayName;
  final String? clienteDisplayName;

  const CasoEntity({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.codigo,
    this.observaciones,
    this.clientePoliza,
    this.displayName,
    this.clienteDisplayName,
  });

  factory CasoEntity.fromJson(Map<String, dynamic> json) => CasoEntity(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        codigo: json["codigo"],
        observaciones: json["observaciones"],
        clientePoliza: json["clientePoliza"] == null
            ? null
            : ClientePoliza.fromJson(json["clientePoliza"]),
        displayName: json["displayName"],
        clienteDisplayName: json["clienteDisplayName"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "codigo": codigo,
        "observaciones": observaciones,
        "clientePoliza": clientePoliza?.toJson(),
        "displayName": displayName,
        "clienteDisplayName": clienteDisplayName,
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        codigo,
        observaciones,
        clientePoliza,
        displayName,
        clienteDisplayName,
      ];
}
