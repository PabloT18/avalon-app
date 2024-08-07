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
