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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'codigo': codigo,
    };
  }

  @override
  List<Object?> get props => [
        id,
        nombre,
        codigo,
      ];
}
