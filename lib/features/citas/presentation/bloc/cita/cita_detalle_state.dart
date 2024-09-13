part of 'cita_detalle_bloc.dart';

sealed class CitaDetalleState extends Equatable {
  const CitaDetalleState();

  @override
  List<Object> get props => [];
}

class CitaDetalleInitial extends CitaDetalleState {}

class CitaDetalleLoaded extends CitaDetalleState {
  final CitaMedica cita;

  const CitaDetalleLoaded({required this.cita});

  @override
  List<Object> get props => [cita];
}

class CitaDetalleError extends CitaDetalleState {
  final String message;

  const CitaDetalleError({required this.message});

  @override
  List<Object> get props => [message];
}
