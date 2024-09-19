part of 'comentario_nuev_cubit.dart';

abstract class ComentarioNuevState extends Equatable {
  const ComentarioNuevState();

  @override
  List<Object?> get props => [];
}

class ComentarioInitial extends ComentarioNuevState {}

class ComentarioImageSelected extends ComentarioNuevState {
  final File image;

  const ComentarioImageSelected({required this.image});

  @override
  List<Object?> get props => [image];
}

class ComentarioSending extends ComentarioNuevState {}

class ComentarioSent extends ComentarioNuevState {}

class ComentarioError extends ComentarioNuevState {
  final String message;

  const ComentarioError(this.message);

  @override
  List<Object> get props => [message];
}
