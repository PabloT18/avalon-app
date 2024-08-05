part of 'preguntas_bloc.dart';

sealed class PreguntasState extends Equatable {
  const PreguntasState();

  @override
  List<Object?> get props => [];
}

class PreguntasInitial extends PreguntasState {
  const PreguntasInitial();
}

class PreguntasLoaded extends PreguntasState {
  const PreguntasLoaded({
    required this.preguntasRaiz,
    required this.preguntasSeleccionadas,
    required this.preguntasNuevas,
    this.isEnd = false,
    this.isLoadingNews = false,
  });

  final List<PreguntaResponse> preguntasRaiz;
  final List<PreguntaResponse> preguntasSeleccionadas;
  final List<PreguntaResponse> preguntasNuevas;

  final bool isEnd;
  final bool isLoadingNews;

  PreguntasLoaded copyWith({
    List<PreguntaResponse>? preguntasRaiz,
    List<PreguntaResponse>? preguntasSeleccionadas,
    List<PreguntaResponse>? preguntasNuevas,
    bool? inEnd,
    bool? isLoadingNews,
  }) {
    return PreguntasLoaded(
      preguntasRaiz: preguntasRaiz ?? this.preguntasRaiz,
      preguntasSeleccionadas:
          preguntasSeleccionadas ?? this.preguntasSeleccionadas,
      preguntasNuevas: preguntasNuevas ?? this.preguntasNuevas,
      isEnd: inEnd ?? isEnd,
      isLoadingNews: isLoadingNews ?? this.isLoadingNews,
    );
  }

  @override
  List<Object?> get props => [
        preguntasRaiz,
        preguntasSeleccionadas,
        preguntasNuevas,
        isEnd,
        isLoadingNews,
      ];
}

class PreguntasError extends PreguntasState {
  final String message;

  const PreguntasError(this.message);

  @override
  List<Object> get props => [message];
}
