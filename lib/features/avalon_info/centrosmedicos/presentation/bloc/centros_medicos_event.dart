part of 'centros_medicos_bloc.dart';

sealed class CentrosMedicosEvent extends Equatable {
  const CentrosMedicosEvent();

  @override
  List<Object> get props => [];
}

class GetCentrosMedicos extends CentrosMedicosEvent {
  const GetCentrosMedicos();
}
