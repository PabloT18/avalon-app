part of 'edit_perfil_bloc.dart';

sealed class EditPerfilEvent extends Equatable {
  const EditPerfilEvent();

  @override
  List<Object> get props => [];
}

class ValidateAndSubmitEvent extends EditPerfilEvent {
  const ValidateAndSubmitEvent();
}
