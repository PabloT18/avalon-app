import 'package:shared_models/shared_models.dart';

class AseguradoraResponse extends Aseguradora {
  const AseguradoraResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombre,
    super.correoElectronico,
    super.estado,
  });

  factory AseguradoraResponse.fromJson(Map<String, dynamic> json) =>
      AseguradoraResponse(
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
        id: json["id"],
        nombre: json["nombre"],
        correoElectronico: json["correoElectronico"],
        estado: json["estado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
        "id": id,
        "nombre": nombre,
        "correoElectronico": correoElectronico,
        "estado": estado,
      };
}
