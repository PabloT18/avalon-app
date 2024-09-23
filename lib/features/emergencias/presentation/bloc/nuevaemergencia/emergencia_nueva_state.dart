part of 'emergencia_nueva_bloc.dart';

class EmergenciaNuevaState extends Equatable {
  const EmergenciaNuevaState({
    this.casos,
    this.message,
    this.casoSeleccionado,
    this.isLoading = false,
    this.waitForCreateCase = false,
  });
  final List<CasoEntity>? casos;
  final String? message;

  final CasoEntity? casoSeleccionado;
  final bool? isLoading;
  final bool waitForCreateCase;

  EmergenciaNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
    CasoEntity? casoSeleccionado,
    bool? isLoading,
    bool? waitForCreateCase,
  }) {
    return EmergenciaNuevaState(
      casos: casos ?? this.casos,
      message: message,
      casoSeleccionado: casoSeleccionado ?? this.casoSeleccionado,
      isLoading: isLoading,
      waitForCreateCase: waitForCreateCase ?? false,
    );
  }

  @override
  List<Object?> get props => [
        casos,
        message,
        casoSeleccionado,
        isLoading,
        waitForCreateCase,
      ];
}

// final class CitaNuevaInitial extends CitaNuevaState {}

// final class CitaNuevaLoading extends CitaNuevaState {}

// final class CitaNuevaSuccess extends CitaNuevaState {}

// final class CitaNuevaError extends CitaNuevaState {}
