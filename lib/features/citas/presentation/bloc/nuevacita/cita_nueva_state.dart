part of 'cita_nueva_bloc.dart';

class CitaNuevaState extends Equatable {
  const CitaNuevaState({
    this.casos,
    this.message,
    this.casoSeleccionado,
    this.isLoading = false,
    this.waitForCreateCase = false,
    this.tipoCita,
    this.paises = const [],
    this.selectedCountryId,
    this.estados = const [],
    this.selectedEstadoId,
    RequisitosAdicionales? requisitosAdicionales,
    this.image,
    this.pdf,
    this.citaCreada,
  }) : requisitosAdicionales = requisitosAdicionales ??
            const RequisitosAdicionales(
              ambTerrestre: false,
              recetaMedica: false,
              ambAerea: false,
              sillaRuedas: false,
              serTransporte: false,
              viajes: false,
              hospedaje: false,
            );
  final List<CasoEntity>? casos;
  final String? message;

  final CasoEntity? casoSeleccionado;
  final bool? isLoading;
  final bool waitForCreateCase;
  final RequisitosAdicionales requisitosAdicionales;

  final String? tipoCita;
  // Nuevos campos para países y estados
  final List<Pais> paises;
  final int? selectedCountryId;
  final List<Estado> estados;
  final int? selectedEstadoId;

  final File? image;
  final File? pdf;

  final bool? citaCreada;

  CitaNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
    CasoEntity? casoSeleccionado,
    bool? isLoading,
    bool? waitForCreateCase,
    RequisitosAdicionales? requisitosAdicionales,
    String? tipoCita,
    List<Pais>? paises,
    int? selectedCountryId,
    List<Estado>? estados,
    int? selectedEstadoId,
    File? image,
    bool removeImage = false,
    File? pdf,
    bool removePdf = false,
    bool? citaCreada,
  }) {
    return CitaNuevaState(
      casos: casos ?? this.casos,
      message: message,
      casoSeleccionado: casoSeleccionado ?? this.casoSeleccionado,
      isLoading: isLoading,
      waitForCreateCase: waitForCreateCase ?? false,
      requisitosAdicionales:
          requisitosAdicionales ?? this.requisitosAdicionales,
      tipoCita: tipoCita ?? this.tipoCita,
      paises: paises ?? this.paises,
      selectedCountryId: selectedCountryId ?? this.selectedCountryId,
      estados: estados ?? this.estados,
      selectedEstadoId: selectedEstadoId ?? this.selectedEstadoId,
      image: removeImage ? null : image ?? this.image,
      pdf: removePdf ? null : pdf ?? this.pdf,
      citaCreada: citaCreada ?? this.citaCreada,
    );
  }

  @override
  List<Object?> get props => [
        casos,
        message,
        casoSeleccionado,
        isLoading,
        waitForCreateCase,
        requisitosAdicionales,
        tipoCita,
        paises,
        selectedCountryId,
        estados,
        selectedEstadoId,
        image,
        pdf,
        citaCreada,
      ];
}
