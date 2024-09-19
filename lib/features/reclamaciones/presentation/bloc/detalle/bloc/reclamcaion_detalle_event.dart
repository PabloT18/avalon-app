part of 'reclamcaion_detalle_bloc.dart';

sealed class ReclamcaionDetalleEvent extends Equatable {
  const ReclamcaionDetalleEvent();

  @override
  List<Object> get props => [];
}

class GetReclamacionHistorial extends ReclamcaionDetalleEvent {
  const GetReclamacionHistorial();
}
