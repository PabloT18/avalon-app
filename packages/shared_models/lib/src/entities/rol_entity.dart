import 'package:equatable/equatable.dart';

class Rol extends Equatable {
  final int? id;
  final String? nombre;
  final String? codigo;

  const Rol({
    this.id,
    this.nombre,
    this.codigo,
  });

  factory Rol.fromJson(Map json) => Rol(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
        codigo: json["codigo"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
      };

  @override
  List<Object?> get props => [
        id,
        nombre,
        codigo,
      ];
}
