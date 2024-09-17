import 'dart:async';

import 'package:avalon_app/app/data/repository/app_repositories_impl.dart';
import 'package:avalon_app/app/domain/repository/user_client_repositoty.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart'
    show TextEditingController, GlobalKey, FormState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

part 'edit_perfil_event.dart';
part 'edit_perfil_state.dart';

class EditPerfilBloc extends Bloc<EditPerfilEvent, EditPerfilState> {
  EditPerfilBloc({required this.user}) : super(const EditPerfilState()) {
    on<ValidateAndSubmitEvent>(_onValidateAndSubmit);

    _userClientRepository = UserClientRepositoryImpl();

    firstName = TextEditingController(text: user.nombres);
    secondName = TextEditingController(text: user.nombresDos);
    firstLastName = TextEditingController(text: user.apellidos);
    secondLastName = TextEditingController(text: user.apellidosDos);

    _emailController = TextEditingController(text: user.correoElectronico);
    _usernameController = TextEditingController(text: user.nombreUsuario);
    _phoneNumberController = TextEditingController(text: user.numeroTelefono);

    if (user is UsrCliente) {
      _birthDateController = TextEditingController(
          text: (user as UsrCliente).formattedFechaNacimiento);
      _birthPlaceController =
          TextEditingController(text: (user as UsrCliente).lugarNacimiento);
      _residenceController =
          TextEditingController(text: (user as UsrCliente).lugarResidencia);
    }
    _statusController = TextEditingController(text: user.estado);
  }

  final User user;

  late UserClientRepository _userClientRepository;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  late TextEditingController firstName;
  late TextEditingController secondName;
  late TextEditingController firstLastName;
  late TextEditingController secondLastName;

  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _birthDateController;
  late TextEditingController _birthPlaceController;
  late TextEditingController _residenceController;
  late TextEditingController _statusController;

  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get birthDateController => _birthDateController;
  TextEditingController get birthPlaceController => _birthPlaceController;
  TextEditingController get residenceController => _residenceController;
  TextEditingController get statusController => _statusController;

  FutureOr<void> _onValidateAndSubmit(
      ValidateAndSubmitEvent event, Emitter<EditPerfilState> emit) async {
    emit(state.copyWith(
      isUpdating: true,
    ));

    if (formKey.currentState!.validate()) {
      try {
        final updatedUser = user.copyWith(
          rolId: user.rol?.id,
          nombres: firstName.text,
          nombresDos: secondName.text,
          apellidos: firstLastName.text,
          apellidosDos: secondLastName.text,
          correoElectronico: _emailController.text,
          numeroTelefono: _phoneNumberController.text,
          lugarNacimiento: _birthPlaceController.text,
          lugarResidencia: _residenceController.text,
          // fechaNacimiento: _birthDateController.text,
        );

        final response = await _userClientRepository.updateClientData(
            user: updatedUser, token: user.token!);
        print(response);

        emit(state.copyWith(
          updateSuccess: response,
          isUpdating: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          updateSuccess: false,
          isUpdating: false,
        ));
      }
    }
  }
}
