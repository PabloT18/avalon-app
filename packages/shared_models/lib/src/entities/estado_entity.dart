import 'package:equatable/equatable.dart';

import 'pais_entity.dart';

class Estado extends Equatable {
  final int? id;
  final String? nombre;
  final Pais? pais;

  const Estado({
    this.id,
    this.nombre,
    this.pais,
  });

  factory Estado.fromJson(Map json) => Estado(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
        pais: json["pais"] != null ? Pais.fromJson(json["pais"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "pais": pais?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        nombre,
        pais,
      ];
}
