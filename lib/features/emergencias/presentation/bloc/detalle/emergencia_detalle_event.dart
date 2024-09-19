part of 'emergencia_detalle_bloc.dart';

sealed class EmergenciaDetalleEvent extends Equatable {
  const EmergenciaDetalleEvent();

  @override
  List<Object> get props => [];
}

class GetEmergenciaHistorial extends EmergenciaDetalleEvent {
  const GetEmergenciaHistorial();
}
