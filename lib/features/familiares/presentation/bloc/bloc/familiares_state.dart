part of 'familiares_bloc.dart';

class FamiliaresState extends Equatable {
  // const FamiliaresState();

  const FamiliaresState({
    required this.clientes,
    required this.polizas,
    this.selectedCliente,
    this.selectedPoliza,
    required this.isLoading,
    required this.isLoadingPolizas,
    required this.hasError,
    required this.familiares,
  });
  final List<UsrCliente> clientes;
  final List<ClientePoliza> polizas;
  final UsrCliente? selectedCliente;
  final ClientePoliza? selectedPoliza;
  final bool isLoading;
  final bool isLoadingPolizas;
  final bool hasError;

  final List<User>? familiares;

  factory FamiliaresState.initial() {
    return const FamiliaresState(
      clientes: [],
      polizas: [],
      selectedCliente: null,
      selectedPoliza: null,
      isLoading: false,
      isLoadingPolizas: false,
      hasError: false,
      familiares: null,
    );
  }

  FamiliaresState copyWith({
    List<UsrCliente>? clientes,
    List<ClientePoliza>? polizas,
    UsrCliente? selectedCliente,
    ClientePoliza? selectedPoliza,
    bool? isLoading,
    bool? isLoadingPolizas,
    bool? hasError,
    List<User>? familiares,
  }) {
    return FamiliaresState(
      clientes: clientes ?? this.clientes,
      polizas: polizas ?? this.polizas,
      selectedCliente: selectedCliente ?? this.selectedCliente,
      selectedPoliza: selectedPoliza ?? this.selectedPoliza,
      isLoading: isLoading ?? this.isLoading,
      isLoadingPolizas: isLoadingPolizas ?? this.isLoadingPolizas,
      hasError: hasError ?? this.hasError,
      familiares: familiares ?? this.familiares,
    );
  }

  @override
  List<Object?> get props => [
        clientes,
        polizas,
        selectedCliente,
        selectedPoliza,
        isLoading,
        isLoadingPolizas,
        hasError,
        familiares,
      ];
}
