part of 'emergencia_detalle_panels_cubit.dart';

sealed class DetallePanelsState extends Equatable {
  const DetallePanelsState(this.index);

  final int index;
  @override
  List<Object> get props => [];
}

final class DetalleInfo extends DetallePanelsState {
  const DetalleInfo() : super(0);
}

final class DetalleHistorial extends DetallePanelsState {
  const DetalleHistorial() : super(1);
}
