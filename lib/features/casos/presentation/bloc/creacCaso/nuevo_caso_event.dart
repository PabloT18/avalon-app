part of 'nuevo_caso_bloc.dart';

abstract class NuevoCasoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadClientesEvent extends NuevoCasoEvent {}

class SetuserAscleinte extends NuevoCasoEvent {
  final UsrCliente cliente;

  SetuserAscleinte(
    this.cliente,
  );

  @override
  List<Object?> get props => [cliente];
}

class SelectClienteEvent extends NuevoCasoEvent {
  final UsrCliente cliente;
  final int clienteId;

  SelectClienteEvent(this.cliente, this.clienteId);

  @override
  List<Object?> get props => [cliente, clienteId];
}

class SelectPolizaEvent extends NuevoCasoEvent {
  final ClientePoliza poliza;

  SelectPolizaEvent(this.poliza);

  @override
  List<Object?> get props => [poliza];
}

class SubmitCasoEvent extends NuevoCasoEvent {}
