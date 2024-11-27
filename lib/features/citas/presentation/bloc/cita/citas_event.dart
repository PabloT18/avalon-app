part of 'citas_bloc.dart';

sealed class CitasEvent extends Equatable {
  const CitasEvent();

  @override
  List<Object> get props => [];
}

class GetCitas extends CitasEvent {
  const GetCitas({this.search});

  final String? search;
}
