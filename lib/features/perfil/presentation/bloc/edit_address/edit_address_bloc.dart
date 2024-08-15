import 'dart:async';

import 'package:flutter/widgets.dart'
    show TextEditingController, GlobalKey, FormState;

import 'package:avalon_app/app/app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

import '../../../../../app/domain/usecases/general_uc/app_general_uses_cases.dart';

part 'edit_address_event.dart';
part 'edit_address_state.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  EditAddressBloc(
      {required this.user,
      required this.getPaisesUseCase,
      required this.getEstadosUseCase})
      : super(EditAddressState(
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
    on<EditAddressEvent>(_onEditAddressEvent);
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  late TextEditingController _addressMain;
  TextEditingController get addressMain => _addressMain;

  late TextEditingController addressSecondary;

  late TextEditingController ciudad;
  late TextEditingController zipCode;

  FutureOr<void> _onEditAddressEvent(
      EditAddressEvent event, Emitter<EditAddressState> emit) async {}

  List<Pais> _paises = [];
  List<Pais> get paises => _paises;

  FutureOr<void> _onLoadPaises(
      LoadPaisesEvent event, Emitter<EditAddressState> emit) async {
    try {
      _paises = await getPaisesUseCase.call(user.token!);

      emit(state.copyWith(paises: _paises));
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

      // Verificar si el selectedEstadoId está en la nueva lista de estados
      if (selectedEstadoId != null &&
          !estados.any((estado) => estado.id == selectedEstadoId)) {
        selectedEstadoId = estados.first
            .id; // Restablecer si el estado seleccionado no está en la lista
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
