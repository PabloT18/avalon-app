part of 'familiares_bloc.dart';

sealed class FamiliaresEvent extends Equatable {
  const FamiliaresEvent();

  @override
  List<Object?> get props => [];
}

class LoadClientesEvent extends FamiliaresEvent {}

class SelectClienteEvent extends FamiliaresEvent {
  final UsrCliente cliente;
  final int clienteId;

  const SelectClienteEvent(this.cliente, this.clienteId);

  @override
  List<Object?> get props => [cliente, clienteId];
}

class SelectPolizaEvent extends FamiliaresEvent {
  final ClientePoliza poliza;

  const SelectPolizaEvent(this.poliza);

  @override
  List<Object?> get props => [poliza];
}

class SetuserAscleinte extends FamiliaresEvent {
  final UsrCliente cliente;

  const SetuserAscleinte(
    this.cliente,
  );

  @override
  List<Object?> get props => [cliente];
}

class GetFamilyMembersEvent extends FamiliaresEvent {
  final ClientePoliza clientePoliza;

  const GetFamilyMembersEvent(this.clientePoliza);

  @override
  List<Object?> get props => [clientePoliza];
}
