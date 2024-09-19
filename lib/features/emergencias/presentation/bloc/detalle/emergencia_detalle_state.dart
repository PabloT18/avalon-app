part of 'emergencia_detalle_bloc.dart';

sealed class EmergenciaDetalleState extends Equatable {
  const EmergenciaDetalleState();

  @override
  List<Object?> get props => [];
}

class EmergenciaDetalleInitial extends EmergenciaDetalleState {}

class EmergenciaDetalleLoaded extends EmergenciaDetalleState {
  const EmergenciaDetalleLoaded({
    required this.emergenciaModel,
    this.comentarios,
    this.messageErrorLoadComentarios,
  });
  final EmergenciaModel emergenciaModel;
  final List<Comentario>? comentarios;
  final String? messageErrorLoadComentarios;

  EmergenciaDetalleLoaded copyWith({
    EmergenciaModel? emergenciaModel,
    List<Comentario>? comentarios,
    String? messageErrorLoadComentarios,
  }) {
    return EmergenciaDetalleLoaded(
      emergenciaModel: emergenciaModel ?? this.emergenciaModel,
      comentarios: comentarios ?? this.comentarios,
      messageErrorLoadComentarios:
          messageErrorLoadComentarios ?? this.messageErrorLoadComentarios,
    );
  }

  @override
  List<Object?> get props => [
        emergenciaModel,
        comentarios,
        messageErrorLoadComentarios,
      ];
}

class EmergenciaDetalleError extends EmergenciaDetalleState {
  final String message;

  const EmergenciaDetalleError({required this.message});

  @override
  List<Object> get props => [message];
}
