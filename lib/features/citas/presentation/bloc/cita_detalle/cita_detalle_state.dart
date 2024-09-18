part of 'cita_detalle_bloc.dart';

sealed class CitaDetalleState extends Equatable {
  const CitaDetalleState();

  @override
  List<Object?> get props => [];
}

class CitaDetalleInitial extends CitaDetalleState {}

class CitaDetalleLoaded extends CitaDetalleState {
  const CitaDetalleLoaded({
    required this.cita,
    this.comentarios,
    this.messageErrorLoadComentarios,
  });
  final CitaMedica cita;
  final List<Comentario>? comentarios;
  final String? messageErrorLoadComentarios;

  CitaDetalleLoaded copyWith({
    CitaMedica? cita,
    List<Comentario>? comentarios,
    String? messageErrorLoadComentarios,
  }) {
    return CitaDetalleLoaded(
      cita: cita ?? this.cita,
      comentarios: comentarios ?? this.comentarios,
      messageErrorLoadComentarios:
          messageErrorLoadComentarios ?? this.messageErrorLoadComentarios,
    );
  }

  @override
  List<Object?> get props => [
        cita,
        comentarios,
        messageErrorLoadComentarios,
      ];
}

class CitaDetalleError extends CitaDetalleState {
  final String message;

  const CitaDetalleError({required this.message});

  @override
  List<Object> get props => [message];
}
