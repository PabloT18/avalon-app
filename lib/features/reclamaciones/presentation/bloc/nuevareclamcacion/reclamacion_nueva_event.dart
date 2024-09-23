part of 'reclamacion_nueva_bloc.dart';

sealed class ReclamacionNuevaEvent extends Equatable {
  const ReclamacionNuevaEvent();

  @override
  List<Object?> get props => [];
}

class GetCasoReclamaciones extends ReclamacionNuevaEvent {
  const GetCasoReclamaciones();
}

class WaitForCreateCase extends ReclamacionNuevaEvent {
  const WaitForCreateCase();
}

class SelectCasoReclamaciones extends ReclamacionNuevaEvent {
  const SelectCasoReclamaciones(this.caso);

  final CasoEntity caso;
}

class SubmitReclamacionesEvent extends ReclamacionNuevaEvent {
  const SubmitReclamacionesEvent({
    this.image,
  });

  final File? image;
}

// Nuevo evento para actualizar tipoAdm
class UpdateTipoAdmEvent extends ReclamacionNuevaEvent {
  final String tipoAdm;
  const UpdateTipoAdmEvent(this.tipoAdm);

  @override
  List<Object> get props => [tipoAdm];
}
