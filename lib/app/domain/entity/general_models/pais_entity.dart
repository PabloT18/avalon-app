import 'package:equatable/equatable.dart';

class Pais extends Equatable {
  final int? id;
  final String? nombre;

  const Pais({
    this.id,
    this.nombre,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };

  @override
  List<Object?> get props => [id, nombre];
}
