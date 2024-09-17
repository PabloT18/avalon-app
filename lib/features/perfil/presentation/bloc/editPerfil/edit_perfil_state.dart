part of 'edit_perfil_bloc.dart';

class EditPerfilState extends Equatable {
  const EditPerfilState({
    this.updateSuccess,
    this.isUpdating = false,
    this.errorMesssage,
  });

  final bool? updateSuccess;
  final bool isUpdating;
  final String? errorMesssage;

  EditPerfilState copyWith({
    bool? updateSuccess,
    bool? isUpdating,
    String? errorMesssage,
  }) {
    return EditPerfilState(
      updateSuccess: updateSuccess ?? this.updateSuccess,
      isUpdating: isUpdating ?? this.isUpdating,
      errorMesssage: errorMesssage,
    );
  }

  @override
  List<Object?> get props => [
        updateSuccess,
        isUpdating,
        errorMesssage,
      ];
}
