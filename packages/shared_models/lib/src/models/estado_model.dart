import 'package:shared_models/shared_models.dart';

class EstadoModel extends Estado {
  const EstadoModel({
    super.id,
    super.nombre,
    super.pais,
  });

  factory EstadoModel.fromJson(Map<String, dynamic> json) => EstadoModel(
        id: json["id"],
        nombre: json["nombre"],
        pais: json["pais"] == null ? null : PaisModel.fromJson(json["pais"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "pais": pais?.toJson(),
      };
}
