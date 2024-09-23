import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'creation_cubit_state.dart';

class CreationCubit extends Cubit<CreationState> {
  CreationCubit() : super(CreationInitial());

  void itemCreated(ItemType itemType) {
    emit(ItemCreated(itemType));
  }

  void reset() {
    emit(CreationInitial());
  }
}
