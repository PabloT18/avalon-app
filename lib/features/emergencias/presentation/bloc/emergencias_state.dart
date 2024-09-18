part of 'emergencias_bloc.dart';

sealed class EmergenciasState extends Equatable {
  const EmergenciasState();

  @override
  List<Object> get props => [];
}

final class EmergenciasInitial extends EmergenciasState {}

class EmergenciasLoaded extends EmergenciasState {
  const EmergenciasLoaded(this.emergencias);
  final List<EmergenciaModel> emergencias;

  EmergenciasLoaded copyWith({
    List<EmergenciaModel>? emergencias,
  }) {
    return EmergenciasLoaded(
      emergencias ?? this.emergencias,
    );
  }

  @override
  List<Object> get props => [emergencias];
}

class EmergenciasError extends EmergenciasState {
  const EmergenciasError(this.message);
  final String message;
}
