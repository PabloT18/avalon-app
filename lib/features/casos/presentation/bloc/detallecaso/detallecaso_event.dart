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

class GetCitas extends DetalleCasoEvent {
  const GetCitas();
}

class GetEmergencias extends DetalleCasoEvent {
  const GetEmergencias();
}

class GetReclamaciones extends DetalleCasoEvent {
  const GetReclamaciones();
}
