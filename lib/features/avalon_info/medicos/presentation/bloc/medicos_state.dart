part of 'medicos_bloc.dart';

sealed class MedicosState extends Equatable {
  const MedicosState();

  @override
  List<Object> get props => [];
}

final class MedicosLoading extends MedicosState {}

final class MedicosLoaded extends MedicosState {
  final List<Medico> medicos;

  const MedicosLoaded(this.medicos);

  @override
  List<Object> get props => [medicos];
}

final class MedicosError extends MedicosState {
  final String message;

  const MedicosError(this.message);

  @override
  List<Object> get props => [message];
}
