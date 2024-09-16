part of 'cita_detalle_panels_cubit.dart';

sealed class CitaDetallePanelsState extends Equatable {
  const CitaDetallePanelsState(this.index);

  final int index;
  @override
  List<Object> get props => [];
}

final class CitaDetalleInfo extends CitaDetallePanelsState {
  const CitaDetalleInfo() : super(0);
}

final class CitaDetalleHistorial extends CitaDetallePanelsState {
  const CitaDetalleHistorial() : super(1);
}
