part of 'emergencia_nueva_bloc.dart';

sealed class EmergenciaNuevaEvent extends Equatable {
  const EmergenciaNuevaEvent();

  @override
  List<Object> get props => [];
}

class GetCasoEmergencia extends EmergenciaNuevaEvent {
  const GetCasoEmergencia();
}

class WaitForCreateCase extends EmergenciaNuevaEvent {
  const WaitForCreateCase();
}

class SelectCasoEmergencia extends EmergenciaNuevaEvent {
  const SelectCasoEmergencia(this.caso);

  final CasoEntity caso;
}
