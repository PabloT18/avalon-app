import 'package:equatable/equatable.dart';

class Pais extends Equatable {
  final int? id;
  final String? nombre;

  const Pais({
    this.id,
    this.nombre,
  });

  factory Pais.fromJson(Map json) => Pais(
        id: json["id"] as int?,
        nombre: json["nombre"] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };

  @override
  List<Object?> get props => [id, nombre];
}
