part of 'medicos_bloc.dart';

sealed class MedicosEvent extends Equatable {
  const MedicosEvent();

  @override
  List<Object> get props => [];
}

class GetMedicos extends MedicosEvent {
  const GetMedicos();
}
