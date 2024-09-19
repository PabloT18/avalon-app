import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'emergencia_detalle_panels_state.dart';

class DetallePanelsCubit extends Cubit<DetallePanelsState> {
  DetallePanelsCubit() : super(const DetalleInfo());

  final PageController pageController = PageController();

  togglePanel(DetallePanelsState stateOption) {
    if (stateOption == state) {
      return;
    }
    // final index = stateOption.index;
    // pageController.animateToPage(index,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

    emit(stateOption);
  }

  void onPageChanged(int value) {
    if (value == 0) {
      emit(const DetalleInfo());
    } else {
      emit(const DetalleHistorial());
    }
  }
}
