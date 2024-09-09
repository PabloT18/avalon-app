import '../entities/broker_entity.dart';

class BrokerResponse extends Broker {
  const BrokerResponse({
    super.createdBy,
    super.createdDate,
    super.lastModifiedBy,
    super.lastModifiedDate,
    super.id,
    super.nombre,
    super.correoElectronico,
    super.estado,
  });

  factory BrokerResponse.fromJson(Map<String, dynamic> json) => BrokerResponse(
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
