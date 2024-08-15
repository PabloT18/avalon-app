import 'package:shared_models/shared_models.dart';

class PaisModel extends Pais {
  const PaisModel({
    super.id,
    super.nombre,
  });

  factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        id: json["id"],
        nombre: json["nombre"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
