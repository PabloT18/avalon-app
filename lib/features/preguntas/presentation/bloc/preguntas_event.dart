part of 'preguntas_bloc.dart';

sealed class PreguntasEvent extends Equatable {
  const PreguntasEvent();

  @override
  List<Object> get props => [];
}

class GetPreguntasEvent extends PreguntasEvent {
  final int id;

  const GetPreguntasEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SeleccionarPregunta extends PreguntasEvent {
  final PreguntaResponse pregunta;

  const SeleccionarPregunta(this.pregunta);

  @override
  List<Object> get props => [pregunta];
}
