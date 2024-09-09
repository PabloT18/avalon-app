part of 'casos_bloc.dart';

sealed class CasosState extends Equatable {
  const CasosState();

  @override
  List<Object> get props => [];
}

final class CasosInitial extends CasosState {}

class CasosLoaded extends CasosState {
  const CasosLoaded({required this.casos});
  final List<CasoEntity> casos;

  CasosLoaded copyWith({
    List<CasoEntity>? casos,
  }) {
    return CasosLoaded(
      casos: casos ?? this.casos,
    );
  }

  @override
  List<Object> get props => [casos, casos.length];
}

class CasosError extends CasosState {
  const CasosError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
