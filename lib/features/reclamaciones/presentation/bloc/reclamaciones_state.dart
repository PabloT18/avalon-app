part of 'reclamaciones_bloc.dart';

sealed class ReclamacionesState extends Equatable {
  const ReclamacionesState();

  @override
  List<Object> get props => [];
}

final class ReclamacionesInitial extends ReclamacionesState {}

class ReclamacionesLoaded extends ReclamacionesState {
  const ReclamacionesLoaded(this.recalmaciones);
  final List<ReclamacionModel> recalmaciones;

  ReclamacionesLoaded copyWith({
    List<ReclamacionModel>? recalmaciones,
  }) {
    return ReclamacionesLoaded(
      recalmaciones ?? this.recalmaciones,
    );
  }

  @override
  List<Object> get props => [recalmaciones];
}

class ReclamacionesError extends ReclamacionesState {
  const ReclamacionesError(this.message);
  final String message;
}
