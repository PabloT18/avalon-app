import 'dart:async';

import 'package:avalon_app/features/casos/data/repository/cliente_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/repository/cliente_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

part 'seguros_event.dart';
part 'seguros_state.dart';

class SegurosBloc extends Bloc<SegurosEvent, SegurosState> {
  SegurosBloc(this.user) : super(SegurosState.initial()) {
    on<SegurosEvent>((event, emit) {});
    on<SeguroLoadClientesEvent>(_onLoadClientes);
    on<SeguroSelectClienteEvent>(_onSelectCliente);
    on<SeguroSetuserAscleinte>(_onSetuserAscleinte);

    if (user is UsrCliente) {
      add(SeguroSetuserAscleinte(user as UsrCliente));
    } else {
      add(SeguroLoadClientesEvent());
    }

    _pageClientes = 0;
    _pageClientesPolizas = 0;

    clientesRepository = ClientesRepositoryImpl();
  }

  late ClientesRepository clientesRepository;
  final User user;

  late int _pageClientes;
  late int _pageClientesPolizas;

  Future<void> _onLoadClientes(
      SeguroLoadClientesEvent event, Emitter<SegurosState> emit) async {
    emit(state.copyWith(isLoading: true));
    final clientesResponse =
        await clientesRepository.getClientes(user, page: _pageClientes);

    clientesResponse.fold(
      (l) => emit(state.copyWith(isLoading: false, hasError: true)),
      (r) => emit(state.copyWith(clientes: r, isLoading: false)),
    );
  }

  Future<void> _onSelectCliente(
      SeguroSelectClienteEvent event, Emitter<SegurosState> emit) async {
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

  FutureOr<void> _onSetuserAscleinte(
      SeguroSetuserAscleinte event, Emitter<SegurosState> emit) {
    emit(state
        .copyWith(clientes: [event.cliente], selectedCliente: event.cliente));
    add(SeguroSelectClienteEvent(event.cliente, event.cliente.id!));
  }
}
