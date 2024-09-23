part of 'reclamacion_nueva_bloc.dart';

const String tipoEmergencia = 'EMERGENCIA';
const String tipoProgramada = 'PROGRAMADA';

class ReclamacionNuevaState extends Equatable {
  const ReclamacionNuevaState({
    this.casos,
    this.message,
    this.casoSeleccionado,
    this.isLoading = false,
    this.waitForCreateCase = false,
    this.tipoAdmSeleccionado,
    this.reclamacionCreada,
    this.image,
  });
  final List<CasoEntity>? casos;
  final String? message;

  final CasoEntity? casoSeleccionado;
  final bool? isLoading;
  final bool waitForCreateCase;

  final String? tipoAdmSeleccionado;
  final bool? reclamacionCreada;

  final File? image;

  String get tipoAdm => tipoAdmSeleccionado ?? '';

  ReclamacionNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
    CasoEntity? casoSeleccionado,
    bool? isLoading,
    bool? waitForCreateCase,
    String? tipoAdmSeleccionado,
    bool? reclamacionCreada,
    File? image,
    bool removeImage = false,
  }) {
    return ReclamacionNuevaState(
      casos: casos ?? this.casos,
      message: message ?? this.message,
      casoSeleccionado: casoSeleccionado ?? this.casoSeleccionado,
      isLoading: isLoading ?? this.isLoading,
      waitForCreateCase: waitForCreateCase ?? this.waitForCreateCase,
      tipoAdmSeleccionado: tipoAdmSeleccionado ?? this.tipoAdmSeleccionado,
      reclamacionCreada: reclamacionCreada,
      image: removeImage ? null : image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        casos,
        message,
        casoSeleccionado,
        isLoading,
        waitForCreateCase,
        tipoAdmSeleccionado,
        reclamacionCreada,
        image,
      ];
}
