part of 'formas_pago_bloc.dart';

sealed class FormasPagoEvent extends Equatable {
  const FormasPagoEvent();

  @override
  List<Object> get props => [];
}

class GetMetodosPagoEvent extends FormasPagoEvent {
  const GetMetodosPagoEvent();
}
