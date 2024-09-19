part of 'seguros_bloc.dart';

sealed class SegurosEvent extends Equatable {
  const SegurosEvent();

  @override
  List<Object?> get props => [];
}

class SeguroLoadClientesEvent extends SegurosEvent {}

class SeguroSetuserAscleinte extends SegurosEvent {
  final UsrCliente cliente;

  const SeguroSetuserAscleinte(
    this.cliente,
  );

  @override
  List<Object?> get props => [cliente];
}

class SeguroSelectClienteEvent extends SegurosEvent {
  final UsrCliente cliente;
  final int clienteId;

  const SeguroSelectClienteEvent(this.cliente, this.clienteId);

  @override
  List<Object?> get props => [cliente, clienteId];
}

class SeguroSelectPolizaEvent extends SegurosEvent {
  final ClientePoliza poliza;

  const SeguroSelectPolizaEvent(this.poliza);

  @override
  List<Object?> get props => [poliza];
}

class SeguroSubmitCasoEvent extends SegurosEvent {}
