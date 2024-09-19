part of 'seguros_bloc.dart';

class SegurosState extends Equatable {
  final List<UsrCliente> clientes;
  final List<ClientePoliza> polizas;
  final UsrCliente? selectedCliente;

  final bool isLoading;
  final bool isLoadingPolizas;
  final bool isSubmitting;
  final bool submitSuccess;
  final bool hasError;

  const SegurosState({
    required this.clientes,
    required this.polizas,
    this.selectedCliente,
    required this.isLoading,
    required this.isLoadingPolizas,
    required this.isSubmitting,
    required this.submitSuccess,
    required this.hasError,
  });

  factory SegurosState.initial() {
    return const SegurosState(
      clientes: [],
      polizas: [],
      selectedCliente: null,
      isLoading: false,
      isLoadingPolizas: false,
      isSubmitting: false,
      submitSuccess: false,
      hasError: false,
    );
  }

  SegurosState copyWith({
    List<UsrCliente>? clientes,
    List<ClientePoliza>? polizas,
    UsrCliente? selectedCliente,
    bool? isLoading,
    bool? isLoadingPolizas,
    bool? isSubmitting,
    bool? submitSuccess,
    bool? hasError,
  }) {
    return SegurosState(
      clientes: clientes ?? this.clientes,
      polizas: polizas ?? this.polizas,
      selectedCliente: selectedCliente ?? this.selectedCliente,
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
        isLoading,
        isLoadingPolizas,
        isSubmitting,
        submitSuccess,
        hasError,
      ];
}
