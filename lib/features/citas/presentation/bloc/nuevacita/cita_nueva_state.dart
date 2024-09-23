part of 'cita_nueva_bloc.dart';

class CitaNuevaState extends Equatable {
  const CitaNuevaState({
    this.casos,
    this.message,
    this.casoSeleccionado,
    this.isLoading = false,
    this.waitForCreateCase = false,
    RequisitosAdicionales? requisitosAdicionales,
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

  CitaNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
    CasoEntity? casoSeleccionado,
    bool? isLoading,
    bool? waitForCreateCase,
    RequisitosAdicionales? requisitosAdicionales,
  }) {
    return CitaNuevaState(
      casos: casos ?? this.casos,
      message: message,
      casoSeleccionado: casoSeleccionado ?? this.casoSeleccionado,
      isLoading: isLoading,
      waitForCreateCase: waitForCreateCase ?? false,
      requisitosAdicionales:
          requisitosAdicionales ?? this.requisitosAdicionales,
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
      ];
}

// final class CitaNuevaInitial extends CitaNuevaState {}

// final class CitaNuevaLoading extends CitaNuevaState {}

// final class CitaNuevaSuccess extends CitaNuevaState {}

// final class CitaNuevaError extends CitaNuevaState {}
