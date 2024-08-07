import 'package:avalon_app/app/app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart'
    show TextEditingController, GlobalKey, FormState;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_perfil_event.dart';
part 'edit_perfil_state.dart';

class EditPerfilBloc extends Bloc<EditPerfilEvent, EditPerfilState> {
  EditPerfilBloc({required this.user}) : super(EditPerfilInitial()) {
    _nombreController = TextEditingController(text: user.nombres);
    _apellidoController = TextEditingController(text: user.apellidos);
    _emailController = TextEditingController(text: user.correoElectronico);
    _usernameController = TextEditingController(text: user.nombreUsuario);
    _phoneNumberController = TextEditingController(text: user.numeroTelefono);
    _birthDateController =
        TextEditingController(text: user.formattedFechaNacimiento);
    _birthPlaceController = TextEditingController(text: user.lugarNacimiento);
    _residenceController = TextEditingController(text: user.lugarResidencia);
    _statusController = TextEditingController(text: user.estado);
  }

  final User user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;

  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _birthDateController;
  late TextEditingController _birthPlaceController;
  late TextEditingController _residenceController;
  late TextEditingController _statusController;

  TextEditingController get nombreController => _nombreController;
  TextEditingController get apellidoController => _apellidoController;
  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get birthDateController => _birthDateController;
  TextEditingController get birthPlaceController => _birthPlaceController;
  TextEditingController get residenceController => _residenceController;
  TextEditingController get statusController => _statusController;
}
