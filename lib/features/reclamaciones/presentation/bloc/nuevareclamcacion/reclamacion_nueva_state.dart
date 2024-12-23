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
    this.pdf,
  });
  final List<CasoEntity>? casos;
  final String? message;

  final CasoEntity? casoSeleccionado;
  final bool? isLoading;
  final bool waitForCreateCase;

  final String? tipoAdmSeleccionado;
  final bool? reclamacionCreada;

  final File? image;
  final File? pdf;

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
    File? pdf,
    bool removeImage = false,
    bool removePdf = false, // <--- Para indicar si queremos remover el PDF
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
      pdf: removePdf ? null : pdf ?? this.pdf,
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
        pdf,
      ];
}
