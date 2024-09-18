import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class Comentario extends Equatable {
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final int? id;
  final String? contenido;
  final User? usuarioComenta;
  final int? imagenId;
  final String? estado;

  const Comentario({
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.id,
    this.contenido,
    this.usuarioComenta,
    this.imagenId,
    this.estado,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
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
        usuarioComenta: json["usuarioComenta"] == null
            ? null
            : User.fromJson(json["usuarioComenta"]),
        imagenId: json["imagenId"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "contenido": contenido,
        "usuarioComenta": usuarioComenta?.toJson(),
        "imagenId": imagenId,
        "estado": estado,
      };

  @override
  List<Object?> get props => [
        createdBy,
        createdDate,
        lastModifiedBy,
        lastModifiedDate,
        id,
        contenido,
        usuarioComenta,
        imagenId,
        estado,
      ];
}
