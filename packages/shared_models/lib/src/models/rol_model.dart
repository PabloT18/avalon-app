import '../entities/rol_entity.dart';

class RolModel extends Rol {
  const RolModel({
    super.id,
    super.nombre,
    super.codigo,
  });

  factory RolModel.fromJson(Map<String, dynamic> json) => RolModel(
        id: json["id"],
        nombre: json["nombre"],
        codigo: json["codigo"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "codigo": codigo,
      };
}
