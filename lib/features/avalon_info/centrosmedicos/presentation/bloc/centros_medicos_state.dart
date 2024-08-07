part of 'centros_medicos_bloc.dart';

sealed class CentrosMedicosState extends Equatable {
  const CentrosMedicosState();

  @override
  List<Object> get props => [];
}

final class CentrosMedicosLoading extends CentrosMedicosState {}

final class CentrosMedicosLoaded extends CentrosMedicosState {
  final List<CentroMedico> centrosMedicos;

  const CentrosMedicosLoaded(this.centrosMedicos);

  @override
  List<Object> get props => [centrosMedicos];
}

final class CentrosMedicosError extends CentrosMedicosState {
  final String message;

  const CentrosMedicosError(this.message);

  @override
  List<Object> get props => [message];
}
