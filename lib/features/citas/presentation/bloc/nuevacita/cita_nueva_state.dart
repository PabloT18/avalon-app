part of 'cita_nueva_bloc.dart';

class CitaNuevaState extends Equatable {
  const CitaNuevaState({
    this.casos,
    this.message,
  });
  final List<CasoEntity>? casos;
  final String? message;

  CitaNuevaState copyWith({
    List<CasoEntity>? casos,
    String? message,
  }) {
    return CitaNuevaState(
      casos: casos ?? this.casos,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        casos,
        message,
      ];
}

// final class CitaNuevaInitial extends CitaNuevaState {}

// final class CitaNuevaLoading extends CitaNuevaState {}

// final class CitaNuevaSuccess extends CitaNuevaState {}

// final class CitaNuevaError extends CitaNuevaState {}
