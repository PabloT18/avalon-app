part of 'nuevo_caso_bloc.dart';

class NuevoCasoState extends Equatable {
  final List<UsrCliente> clientes;
  final List<ClientePoliza> polizas;
  final UsrCliente? selectedCliente;
  final ClientePoliza? selectedPoliza;
  final bool isLoading;
  final bool isLoadingPolizas;
  final bool isSubmitting;
  final bool submitSuccess;
  final bool hasError;

  const NuevoCasoState({
    required this.clientes,
    required this.polizas,
    this.selectedCliente,
    this.selectedPoliza,
    required this.isLoading,
    required this.isLoadingPolizas,
    required this.isSubmitting,
    required this.submitSuccess,
    required this.hasError,
  });

  factory NuevoCasoState.initial() {
    return const NuevoCasoState(
      clientes: [],
      polizas: [],
      selectedCliente: null,
      selectedPoliza: null,
      isLoading: false,
      isLoadingPolizas: false,
      isSubmitting: false,
      submitSuccess: false,
      hasError: false,
    );
  }

  NuevoCasoState copyWith({
    List<UsrCliente>? clientes,
    List<ClientePoliza>? polizas,
    UsrCliente? selectedCliente,
    ClientePoliza? selectedPoliza,
    bool? isLoading,
    bool? isLoadingPolizas,
    bool? isSubmitting,
    bool? submitSuccess,
    bool? hasError,
  }) {
    return NuevoCasoState(
      clientes: clientes ?? this.clientes,
      polizas: polizas ?? this.polizas,
      selectedCliente: selectedCliente ?? this.selectedCliente,
      selectedPoliza: selectedPoliza ?? this.selectedPoliza,
      isLoading: isLoading ?? this.isLoading,
      isLoadingPolizas: isLoadingPolizas ?? this.isLoadingPolizas,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: submitSuccess ?? this.submitSuccess,
      hasError: hasError ?? this.hasError,
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
        isSubmitting,
        submitSuccess,
        hasError,
      ];
}
