part of 'edit_address_bloc.dart';

sealed class EditAddressEvent extends Equatable {
  const EditAddressEvent();

  @override
  List<Object> get props => [];
}

class LoadPaisesEvent extends EditAddressEvent {}

class UpdateSelectedCountryEvent extends EditAddressEvent {
  final int selectedCountryId;

  const UpdateSelectedCountryEvent(this.selectedCountryId);

  @override
  List<Object> get props => [selectedCountryId];
}

class LoadEstadosEvent extends EditAddressEvent {
  final int paisId;

  const LoadEstadosEvent(this.paisId);

  @override
  List<Object> get props => [paisId];
}

class UpdateSelectedEstadoEvent extends EditAddressEvent {
  final int selectedEstadoId;

  const UpdateSelectedEstadoEvent(this.selectedEstadoId);

  @override
  List<Object> get props => [selectedEstadoId];
}
