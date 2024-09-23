import 'dart:async';

import 'package:avalon_app/features/casos/data/repository/cliente_repository_impl.dart';
import 'package:avalon_app/features/casos/domain/repository/cliente_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_models/shared_models.dart';

part 'familiares_event.dart';
part 'familiares_state.dart';

class FamiliaresBloc extends Bloc<FamiliaresEvent, FamiliaresState> {
  FamiliaresBloc(this.user) : super(FamiliaresState.initial()) {
    on<SelectClienteEvent>(_onSelectCliente);
    on<SelectPolizaEvent>(_onSelectPoliza);
    on<LoadClientesEvent>(_onLoadClientes);
    on<SetuserAscleinte>(_onSetuserAscleinte);
    on<GetFamilyMembersEvent>(_onGetFamilyMembers);

    clientesRepository = ClientesRepositoryImpl();
    if (user is UsrCliente) {
      add(SetuserAscleinte(user as UsrCliente));
    } else {
      add(LoadClientesEvent());
    }
  }

  late ClientesRepository clientesRepository;
  final User user;

  Future<void> _onLoadClientes(
      LoadClientesEvent event, Emitter<FamiliaresState> emit) async {
    emit(state.copyWith(isLoading: true));
    final clientesResponse =
        await clientesRepository.getClientes(user, page: 0);

    clientesResponse.fold(
      (l) => emit(state.copyWith(isLoading: false, hasError: true)),
      (r) => emit(state.copyWith(clientes: r, isLoading: false)),
    );
  }

  Future<void> _onSelectCliente(
      SelectClienteEvent event, Emitter<FamiliaresState> emit) async {
    emit(state.copyWith(isLoadingPolizas: true));
    final polizasResponse = await clientesRepository
        .getClientesPolizas(user, event.cliente.id!, page: 0);

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
          add(GetFamilyMembersEvent(r.first));
        } else {
          emit(state.copyWith(
              selectedCliente: event.cliente,
              polizas: r,
              isLoadingPolizas: false));
        }
      }
    });
  }

  void _onSelectPoliza(SelectPolizaEvent event, Emitter<FamiliaresState> emit) {
    emit(state.copyWith(selectedPoliza: event.poliza));
    add(GetFamilyMembersEvent(event.poliza));
  }

  FutureOr<void> _onSetuserAscleinte(
      SetuserAscleinte event, Emitter<FamiliaresState> emit) {
    emit(state
        .copyWith(clientes: [event.cliente], selectedCliente: event.cliente));
    // add(SelectClienteEvent(event.cliente, event.cliente.id!));
  }

  FutureOr<void> _onGetFamilyMembers(
      GetFamilyMembersEvent event, Emitter<FamiliaresState> emit) async {
    final familiaresResponse = await clientesRepository.getFamiliares(
      user,
      event.clientePoliza.id!,
      page: 0,
    );

    familiaresResponse.fold(
      (l) => emit(state.copyWith(hasError: true)),
      (r) => emit(state.copyWith(familiares: r)),
    );
  }
}
