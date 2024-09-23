part of 'cita_nueva_bloc.dart';

sealed class CitaNuevaEvent extends Equatable {
  const CitaNuevaEvent();

  @override
  List<Object?> get props => [];
}

class GetCasosCita extends CitaNuevaEvent {
  const GetCasosCita();
}

class WaitForCreateCase extends CitaNuevaEvent {
  const WaitForCreateCase();
}

class SubmitCitaEvent extends CitaNuevaEvent {
  const SubmitCitaEvent({
    this.image,
  });

  final File? image;
}

class SelectCaso extends CitaNuevaEvent {
  const SelectCaso(this.caso);

  final CasoEntity caso;
}

class UpdateRequisitoAdicional extends CitaNuevaEvent {
  final String field;
  final bool value;

  const UpdateRequisitoAdicional({required this.field, required this.value});

  @override
  List<Object?> get props => [field, value];
}
