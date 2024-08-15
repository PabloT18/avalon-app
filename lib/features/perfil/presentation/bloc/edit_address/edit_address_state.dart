part of 'edit_address_bloc.dart';

class EditAddressState extends Equatable {
  const EditAddressState({
    required this.paises,
    this.selectedCountryId,
    this.estados = const [],
    this.selectedEstadoId,
    this.updateSuccess,
    this.isUpdating = false,
  });

  final List<Pais> paises;
  final int? selectedCountryId;
  final List<Estado> estados; // Lista de estados
  final int? selectedEstadoId; // ID del estado seleccionado

  final bool? updateSuccess;
  final bool isUpdating;

  EditAddressState copyWith({
    List<Pais>? paises,
    int? selectedCountryId,
    List<Estado>? estados,
    int? selectedEstadoId,
    bool? updateSuccess,
    bool? isUpdating,
  }) {
    return EditAddressState(
      paises: paises ?? this.paises,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
      estados: estados ?? this.estados,
      selectedEstadoId: selectedEstadoId ?? this.selectedEstadoId,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props => [
        paises,
        selectedCountryId,
        estados,
        selectedEstadoId,
        updateSuccess,
        isUpdating,
      ];
}
