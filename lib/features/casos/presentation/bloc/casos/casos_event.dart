part of 'casos_bloc.dart';

sealed class CasosEvent extends Equatable {
  const CasosEvent();

  @override
  List<Object> get props => [];
}

class GetCasosUser extends CasosEvent {
  const GetCasosUser({
    this.clientePolizaId,
    this.search,
  });

  final int? clientePolizaId;
  final String? search;
}

class GetCasosUserNextPage extends CasosEvent {
  const GetCasosUserNextPage({
    this.clientePolizaId,
  });

  final int? clientePolizaId;
}
