part of 'reclamaciones_bloc.dart';

sealed class ReclamacionesEvent extends Equatable {
  const ReclamacionesEvent();

  @override
  List<Object> get props => [];
}

class GetReclamaciones extends ReclamacionesEvent {
  const GetReclamaciones({this.search});
  final String? search;
}

class GetReclamacionesNextPage extends ReclamacionesEvent {
  const GetReclamacionesNextPage();
}
