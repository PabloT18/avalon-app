part of 'citas_bloc.dart';

sealed class CitasState extends Equatable {
  const CitasState();

  @override
  List<Object> get props => [];
}

class CitasInitial extends CitasState {}

class CitasLoaded extends CitasState {
  const CitasLoaded(this.citas);
  final List<CitaMedica> citas;

  CitasLoaded copyWith({
    List<CitaMedica>? citas,
  }) {
    return CitasLoaded(
      citas ?? this.citas,
    );
  }

  @override
  List<Object> get props => [citas];
}

class CitasError extends CitasState {
  const CitasError(this.message);
  final String message;
}
