import 'dart:async';

import 'package:avalon_app/features/casos/casos.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:shared_models/shared_models.dart';

import '../../../data/repository/cliente_repository_impl.dart';
import '../../../domain/repository/cliente_repository.dart';

part 'nuevo_caso_event.dart';
part 'nuevo_caso_state.dart';

class NuevoCasoBloc extends Bloc<NuevoCasoEvent, NuevoCasoState> {
  NuevoCasoBloc(
    this.user,
  ) : super(NuevoCasoState.initial()) {
    on<LoadClientesEvent>(_onLoadClientes);
    on<SelectClienteEvent>(_onSelectCliente);
    on<SelectPolizaEvent>(_onSelectPoliza);
    on<SubmitCasoEvent>(_onSubmitCaso);
    on<SetuserAscleinte>(_onSetuserAscleinte);

    casosRepository = CasosRepositoryImpl();
    clientesRepository = ClientesRepositoryImpl();

    if (user is UsrCliente) {
      add(SetuserAscleinte(user as UsrCliente));
    } else {
      add(LoadClientesEvent());
    }
    _pageClientes = 0;
    _pageClientesPolizas = 0;

    observacionesController = TextEditingController();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  late CasosRepository casosRepository;
  late ClientesRepository clientesRepository;
  final User user;

  late int _pageClientes;
  late int _pageClientesPolizas;

  late TextEditingController observacionesController;

  @override
  Future<void> close() {
    observacionesController.dispose();
    return super.close();
  }

  Future<void> _onLoadClientes(
      LoadClientesEvent event, Emitter<NuevoCasoState> emit) async {
    emit(state.copyWith(isLoading: true));
    final clientesResponse =
        await clientesRepository.getClientes(user, page: _pageClientes);

    clientesResponse.fold(
      (l) => emit(state.copyWith(isLoading: false, hasError: true)),
      (r) => emit(state.copyWith(clientes: r, isLoading: false)),
    );
  }

  Future<void> _onSelectCliente(
      SelectClienteEvent event, Emitter<NuevoCasoState> emit) async {
    emit(state.copyWith(isLoadingPolizas: true));
    final polizasResponse = await clientesRepository.getClientesPolizas(
        user, event.cliente.id!,
        page: _pageClientesPolizas);

    polizasResponse.fold(
        (l) => emit(state.copyWith(isLoadingPolizas: false, hasError: true)),
        (r) {
      if (r.isEmpty) {
        emit(state.copyWith(
            hasError: true, polizas: r, isLoadingPolizas: false));
      } else {
        if (r.length == 1) {
          emit(state.copyWith(
            selectedCliente: event.cliente,
            polizas: r,
            isLoadingPolizas: false,
            selectedPoliza: r.first,
          ));
        } else {
          emit(state.copyWith(
              selectedCliente: event.cliente,
              polizas: r,
              isLoadingPolizas: false));
        }
      }
    });
  }

  void _onSelectPoliza(SelectPolizaEvent event, Emitter<NuevoCasoState> emit) {
    emit(state.copyWith(selectedPoliza: event.poliza));
  }

  Future<void> _onSubmitCaso(
      SubmitCasoEvent event, Emitter<NuevoCasoState> emit) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(isSubmitting: true));
      final result = await casosRepository.crearCaso(
        user,
        observacionesController.text,
        state.selectedPoliza!.id!,
      );
      observacionesController.clear();

      result.fold(
          (l) =>
              emit(state.copyWith(isSubmitting: false, submitSuccess: false)),
          (r) => emit(state.copyWith(
                isSubmitting: false,
                submitSuccess: true,
                casoCreado: r,
              )));
    }
  }

  FutureOr<void> _onSetuserAscleinte(
      SetuserAscleinte event, Emitter<NuevoCasoState> emit) {
    emit(state
        .copyWith(clientes: [event.cliente], selectedCliente: event.cliente));
    add(SelectClienteEvent(event.cliente, event.cliente.id!));
  }
}
