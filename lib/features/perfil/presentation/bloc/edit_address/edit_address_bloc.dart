import 'dart:async';

import 'package:flutter/widgets.dart'
    show TextEditingController, GlobalKey, FormState;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../../../../../app/domain/usecases/general_uc/app_general_uses_cases.dart';
import '../../../domain/use_cases/update_user_data_uc.dart';

part 'edit_address_event.dart';
part 'edit_address_state.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  EditAddressBloc({
    required this.user,
    required this.getPaisesUseCase,
    required this.getEstadosUseCase,
    required this.updateUserAddressUseCase,
  }) : super(EditAddressState(
          paises: [
            if (user.direccion?.pais != null)
              Pais(
                  id: user.direccion!.pais!.id,
                  nombre: user.direccion!.pais!.nombre)
          ],
          selectedCountryId: user.direccion?.pais?.id,
          selectedEstadoId: user.direccion?.estado?.id,
          estados: const [],
        )) {
    on<ValidateAndSubmitEvent>(_onValidateAndSubmit);
    on<LoadPaisesEvent>(_onLoadPaises);
    on<LoadEstadosEvent>(_onLoadEstados); // Manejar la carga de estados
    on<UpdateSelectedCountryEvent>(_onUpdateSelectedCountry);
    on<UpdateSelectedEstadoEvent>(_onUpdateSelectedEstado);

    _addressMain = TextEditingController(text: user.direccion?.direccionUno);
    addressSecondary =
        TextEditingController(text: user.direccion?.direccionDos);

    ciudad = TextEditingController(text: user.direccion?.ciudad);
    zipCode = TextEditingController(text: user.direccion?.codigoPostal);
    // Si hay un país seleccionado, cargar los estados
    if (state.selectedCountryId != null) {
      add(LoadEstadosEvent(state.selectedCountryId!));
    }
  }

  final User user;
  final GetPaisesUseCase getPaisesUseCase;
  final GetEstadosUseCase getEstadosUseCase;
  final UpdateUserAddressUseCase updateUserAddressUseCase;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  late TextEditingController _addressMain;
  TextEditingController get addressMain => _addressMain;

  late TextEditingController addressSecondary;

  late TextEditingController ciudad;
  late TextEditingController zipCode;

  FutureOr<void> _onValidateAndSubmit(
      EditAddressEvent event, Emitter<EditAddressState> emit) async {
    emit(state.copyWith(
      isUpdating: true,
    ));
    if (formKey.currentState!.validate()) {
      try {
        final updatedUser = user.copyWith(
          rolId: user.rol?.id,
          direccion: Direccion(
            direccionUno: _addressMain.text,
            direccionDos: addressSecondary.text,
            ciudad: ciudad.text,
            codigoPostal: zipCode.text,
            paisId: state.selectedCountryId,
            estadoId: state.selectedEstadoId,
          ),
        );

        final response =
            await updateUserAddressUseCase.call(updatedUser, user.token!);
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

  FutureOr<void> _onLoadPaises(
      LoadPaisesEvent event, Emitter<EditAddressState> emit) async {
    try {
      List<Pais> paises = await getPaisesUseCase.call(user.token!);

      emit(state.copyWith(paises: paises));
    } catch (e) {
      print('Error al cargar países: $e');
    }
  }

  FutureOr<void> _onUpdateSelectedCountry(
      UpdateSelectedCountryEvent event, Emitter<EditAddressState> emit) {
    add(LoadEstadosEvent(event.selectedCountryId));
    emit(state.copyWith(selectedCountryId: event.selectedCountryId));
  }

  Future<void> _onLoadEstados(
      LoadEstadosEvent event, Emitter<EditAddressState> emit) async {
    try {
      final estados =
          await getEstadosUseCase(paisId: event.paisId, token: user.token!);
      int? selectedEstadoId = state.selectedEstadoId;

      if (!estados.any((estado) => estado.id == selectedEstadoId)) {
        selectedEstadoId = estados.first.id;
      }

      emit(state.copyWith(
        estados: estados,
        selectedEstadoId: selectedEstadoId,
      ));
    } catch (e) {
      print('Error al cargar estados: $e');
    }
  }

  void _onUpdateSelectedEstado(
      UpdateSelectedEstadoEvent event, Emitter<EditAddressState> emit) {
    emit(state.copyWith(selectedEstadoId: event.selectedEstadoId));
  }
}
