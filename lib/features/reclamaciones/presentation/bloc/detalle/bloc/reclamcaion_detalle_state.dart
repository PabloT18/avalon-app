part of 'reclamcaion_detalle_bloc.dart';

sealed class ReclamacionDetalleState extends Equatable {
  const ReclamacionDetalleState();

  @override
  List<Object?> get props => [];
}

final class ReclamacionDetalleInitial extends ReclamacionDetalleState {}

class ReclamacionDetalleLoaded extends ReclamacionDetalleState {
  const ReclamacionDetalleLoaded({
    required this.reclamacion,
    this.comentarios,
    this.messageErrorLoadComentarios,
  });
  final ReclamacionModel reclamacion;
  final List<Comentario>? comentarios;
  final String? messageErrorLoadComentarios;

  ReclamacionDetalleLoaded copyWith({
    ReclamacionModel? reclamacion,
    List<Comentario>? comentarios,
    String? messageErrorLoadComentarios,
  }) {
    return ReclamacionDetalleLoaded(
      reclamacion: reclamacion ?? this.reclamacion,
      comentarios: comentarios ?? this.comentarios,
      messageErrorLoadComentarios: messageErrorLoadComentarios,
    );
  }

  @override
  List<Object?> get props => [
        reclamacion,
        comentarios,
        messageErrorLoadComentarios,
      ];
}

class ReclamacionDetalleError extends ReclamacionDetalleState {
  final String message;

  const ReclamacionDetalleError({required this.message});

  @override
  List<Object> get props => [message];
}
