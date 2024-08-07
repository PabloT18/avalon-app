part of 'formas_pago_bloc.dart';

sealed class FormasPagoState extends Equatable {
  const FormasPagoState();

  @override
  List<Object> get props => [];
}

final class FormasPagoInitial extends FormasPagoState {}

final class FormasPagoLoading extends FormasPagoState {}

final class FormasPagoLoaded extends FormasPagoState {
  final List<MetodoPago> metodosPago;

  const FormasPagoLoaded(this.metodosPago);

  @override
  List<Object> get props => [metodosPago];
}

final class FormasPagoError extends FormasPagoState {
  final String message;

  const FormasPagoError(this.message);

  @override
  List<Object> get props => [message];
}
