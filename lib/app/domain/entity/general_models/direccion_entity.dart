import 'package:equatable/equatable.dart';

import 'estado_entity.dart';
import 'pais_entity.dart';

class Direccion extends Equatable {
  final String? direccionUno;
  final String? direccionDos;
  final String? ciudad;
  final String? codigoPostal;
  final Pais? pais;
  final Estado? estado;

  const Direccion({
    this.direccionUno,
    this.direccionDos,
    this.ciudad,
    this.codigoPostal,
    this.pais,
    this.estado,
  });

  Map<String, dynamic> toJson() => {
        "direccionUno": direccionUno,
        "direccionDos": direccionDos,
        "ciudad": ciudad,
        "codigoPostal": codigoPostal,
        "pais": pais?.toJson(),
        "state": estado?.toJson(),
      };

  bool get isComplete {
    return direccionUno != null &&
        ciudad != null &&
        codigoPostal != null &&
        estado != null &&
        estado!.nombre != null &&
        estado!.pais != null &&
        estado!.pais!.nombre != null;
  }

  @override
  List<Object?> get props => [
        direccionUno,
        direccionDos,
        ciudad,
        codigoPostal,
        pais,
        estado,
      ];
}
