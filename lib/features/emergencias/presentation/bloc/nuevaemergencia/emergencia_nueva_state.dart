part of 'emergencia_nueva_bloc.dart';

class EmergenciaNuevaState extends Equatable {
  const EmergenciaNuevaState({
    this.casos,
    this.message,
    this.casoSeleccionado,
    this.isLoading = false,
    this.waitForCreateCase = false,
    this.paises = const [],
    this.selectedCountryId,
    this.estados = const [],
    this.selectedEstadoId,
  });
  final List<CasoEntity>? casos;
  final String? message;

  final CasoEntity? casoSeleccionado;
  final bool? isLoading;
  final bool waitForCreateCase;

  // Nuevos campos para países y estados
  final List<Pais> paises;
  final int? selectedCountryId;
  final List<Estado> estados;
  final int? selectedEstadoId;

  EmergenciaNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
    CasoEntity? casoSeleccionado,
    bool? isLoading,
    bool? waitForCreateCase,
    List<Pais>? paises,
    int? selectedCountryId,
    List<Estado>? estados,
    int? selectedEstadoId,
  }) {
    return EmergenciaNuevaState(
      casos: casos ?? this.casos,
      message: message ?? this.message,
      casoSeleccionado: casoSeleccionado ?? this.casoSeleccionado,
      isLoading: isLoading ?? this.isLoading,
      waitForCreateCase: waitForCreateCase ?? this.waitForCreateCase,
      paises: paises ?? this.paises,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
      estados: estados ?? this.estados,
      selectedEstadoId: selectedEstadoId ?? this.selectedEstadoId,
    );
  }

  @override
  List<Object?> get props => [
        casos,
        message,
        casoSeleccionado,
        isLoading,
        waitForCreateCase,
        paises,
        selectedCountryId,
        estados,
        selectedEstadoId,
      ];
}
