part of 'cita_nueva_bloc.dart';

sealed class CitaNuevaEvent extends Equatable {
  const CitaNuevaEvent();

  @override
  List<Object> get props => [];
}

class GetCasosCita extends CitaNuevaEvent {
  const GetCasosCita();
}
