part of 'detallecaso_bloc.dart';

sealed class DetalleCasoEvent extends Equatable {
  const DetalleCasoEvent();

  @override
  List<Object> get props => [];
}

class SelectCasoOption extends DetalleCasoEvent {
  const SelectCasoOption(this.optionSelected);

  final CasoOption? optionSelected;
}

class CDGetCitas extends DetalleCasoEvent {
  const CDGetCitas();
}

class CDGetEmergencias extends DetalleCasoEvent {
  const CDGetEmergencias();
}

class CDGetReclamaciones extends DetalleCasoEvent {
  const CDGetReclamaciones();
}
