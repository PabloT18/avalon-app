import 'package:shared_models/shared_models.dart';

class DireccionModel extends Direccion {
  const DireccionModel({
    super.direccionUno,
    super.direccionDos,
    super.ciudad,
    super.codigoPostal,
    super.pais,
    super.estado,
  });

  factory DireccionModel.fromJson(Map<String, dynamic> json) => DireccionModel(
        direccionUno: json["direccionUno"],
        direccionDos: json["direccionDos"],
        ciudad: json["ciudad"],
        codigoPostal: json["codigoPostal"],
        pais: json["pais"] == null ? null : PaisModel.fromJson(json["pais"]),
        estado:
            json["state"] == null ? null : EstadoModel.fromJson(json["state"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "direccionUno": direccionUno,
        "direccionDos": direccionDos,
        "ciudad": ciudad,
        "codigoPostal": codigoPostal,
        "pais": pais?.toJson(),
        "state": estado?.toJson(),
      };
}
