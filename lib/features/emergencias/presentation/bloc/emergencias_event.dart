part of 'emergencias_bloc.dart';

sealed class EmergenciasEvent extends Equatable {
  const EmergenciasEvent();

  @override
  List<Object> get props => [];
}

class GetEmergencias extends EmergenciasEvent {
  const GetEmergencias({this.search});
  final String? search;
}

class GetEmergenciasNextPage extends EmergenciasEvent {
  const GetEmergenciasNextPage();
}
