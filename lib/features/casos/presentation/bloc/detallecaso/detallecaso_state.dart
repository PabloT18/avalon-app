part of 'detallecaso_bloc.dart';

enum CasoOption {
  caso,
  citas,
  reembolso,
  emergencia,
}

sealed class DetalleCasoState extends Equatable {
  const DetalleCasoState();

  @override
  List<Object?> get props => [];
}

final class DetallecasoInitial extends DetalleCasoState {}

final class DetalleCasoLoaded extends DetalleCasoState {
  const DetalleCasoLoaded({
    required this.caso,
    this.optionSelected = CasoOption.caso,
    this.citas,
    this.emergencias,
    this.erroCitas,
    this.errorEmergencias,
    this.loadingCitas,
    this.loadingEmergencias,
    this.loadingReclamaciones,
  });
  final CasoEntity caso;

  final CasoOption optionSelected;

  final List<EmergenciaModel>? emergencias;
  final List<CitaMedica>? citas;

  final String? erroCitas;
  final String? errorEmergencias;

  final bool? loadingCitas;
  final bool? loadingEmergencias;
  final bool? loadingReclamaciones;

  DetalleCasoLoaded copyWith({
    CasoEntity? caso,
    CasoOption? optionSelected,
    List<EmergenciaModel>? emergencias,
    List<CitaMedica>? citas,
    String? erroCitas,
    String? errorEmergencias,
    bool? loadingCitas,
    bool? loadingEmergencias,
    bool? loadingReclamaciones,
  }) {
    return DetalleCasoLoaded(
      caso: caso ?? this.caso,
      optionSelected: optionSelected ?? this.optionSelected,
      emergencias: emergencias ?? this.emergencias,
      citas: citas ?? this.citas,
      erroCitas: erroCitas,
      errorEmergencias: errorEmergencias,
      loadingCitas: loadingCitas,
      loadingEmergencias: loadingEmergencias,
      loadingReclamaciones: loadingReclamaciones,
    );
  }

  @override
  List<Object?> get props => [
        caso,
        optionSelected,
        emergencias,
        citas,
        erroCitas,
        errorEmergencias,
        loadingCitas,
        loadingEmergencias,
        loadingReclamaciones,
      ];
}

final class DetalleCasoError extends DetalleCasoState {
  const DetalleCasoError(this.message);
  final String message;
}
