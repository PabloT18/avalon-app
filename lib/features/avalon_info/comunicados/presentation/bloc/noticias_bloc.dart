import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'noticias_event.dart';
part 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
  NoticiasBloc() : super(NoticiasInitial()) {
    on<NoticiasEvent>((event, emit) {});
  }
}
