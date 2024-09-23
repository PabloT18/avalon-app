import 'package:equatable/equatable.dart';

class RequisitosAdicionales extends Equatable {
  final bool? ambTerrestre;
  final bool? recetaMedica;
  final bool? ambAerea;
  final bool? sillaRuedas;
  final bool? serTransporte;
  final bool? viajes;
  final bool? hospedaje;

  const RequisitosAdicionales({
    this.ambTerrestre,
    this.recetaMedica,
    this.ambAerea,
    this.sillaRuedas,
    this.serTransporte,
    this.viajes,
    this.hospedaje,
  });

  factory RequisitosAdicionales.fromJson(Map<String, dynamic> json) =>
      RequisitosAdicionales(
        ambTerrestre: json["AMB_TERRESTRE"],
        recetaMedica: json["RECETA_MEDICA"],
        ambAerea: json["AMB_AEREA"],
        sillaRuedas: json["SILLA_RUEDAS"],
        serTransporte: json["SER_TRANSPORTE"],
        viajes: json["VIAJES"],
        hospedaje: json["HOSPEDAJE"],
      );

  Map<String, dynamic> toJson() => {
        "AMB_TERRESTRE": ambTerrestre,
        "RECETA_MEDICA": recetaMedica,
        "AMB_AEREA": ambAerea,
        "SILLA_RUEDAS": sillaRuedas,
        "SER_TRANSPORTE": serTransporte,
        "VIAJES": viajes,
        "HOSPEDAJE": hospedaje,
      };

  RequisitosAdicionales copyWith({
    bool? ambTerrestre,
    bool? recetaMedica,
    bool? ambAerea,
    bool? sillaRuedas,
    bool? serTransporte,
    bool? viajes,
    bool? hospedaje,
  }) {
    return RequisitosAdicionales(
      ambTerrestre: ambTerrestre ?? this.ambTerrestre,
      recetaMedica: recetaMedica ?? this.recetaMedica,
      ambAerea: ambAerea ?? this.ambAerea,
      sillaRuedas: sillaRuedas ?? this.sillaRuedas,
      serTransporte: serTransporte ?? this.serTransporte,
      viajes: viajes ?? this.viajes,
      hospedaje: hospedaje ?? this.hospedaje,
    );
  }

  @override
  List<Object?> get props => [
        ambTerrestre,
        recetaMedica,
        ambAerea,
        sillaRuedas,
        serTransporte,
        viajes,
        hospedaje,
      ];
}
