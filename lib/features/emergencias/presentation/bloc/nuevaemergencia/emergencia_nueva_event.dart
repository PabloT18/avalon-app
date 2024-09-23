part of 'emergencia_nueva_bloc.dart';

sealed class EmergenciaNuevaEvent extends Equatable {
  const EmergenciaNuevaEvent();

  @override
  List<Object?> get props => [];
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

class SubmitEmergenciaEvent extends EmergenciaNuevaEvent {
  const SubmitEmergenciaEvent({
    this.image,
  });

  final File? image;
}

// Nuevos eventos para países y estados
class LoadPaisesEvent extends EmergenciaNuevaEvent {
  const LoadPaisesEvent();
}

class UpdateSelectedCountryEvent extends EmergenciaNuevaEvent {
  final int countryId;
  const UpdateSelectedCountryEvent(this.countryId);

  @override
  List<Object?> get props => [countryId];
}

class UpdateSelectedEstadoEvent extends EmergenciaNuevaEvent {
  final int estadoId;
  const UpdateSelectedEstadoEvent(this.estadoId);

  @override
  List<Object?> get props => [estadoId];
}
