import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:shared_models/shared_models.dart';

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

  factory Direccion.fromJson(Map json) => Direccion(
        direccionUno: json["direccionUno"] as String?,
        direccionDos: json["direccionDos"] as String?,
        ciudad: json["ciudad"] as String?,
        codigoPostal: json["codigoPostal"] as String?,
        pais: json["pais"] != null ? Pais.fromJson(json["pais"] as Map) : null,
        estado: json["state"] != null
            ? Estado.fromJson(json["state"] as Map)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "direccionUno": direccionUno,
        "direccionDos": direccionDos,
        "ciudad": ciudad,
        "codigoPostal": codigoPostal,
        "pais": pais?.toJson(),
        "state": estado?.toJson(),
      };

  String get direccionCompleta {
    if (direccionUno != null) {
      if (direccionDos != null && direccionDos!.isNotEmpty) {
        return '$direccionUno, $direccionDos';
      } else {
        return direccionUno!;
      }
    }
    return '-';
  }

  String get estadoNombreCompleto {
    if (estado != null) {
      return '${estado!.nombre}, ${estado!.pais!.nombre}';
    }
    return '-';
  }

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
