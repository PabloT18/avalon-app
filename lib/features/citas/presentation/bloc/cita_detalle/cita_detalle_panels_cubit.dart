import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cita_detalle_panels_state.dart';

class CitaDetallePanelsCubit extends Cubit<CitaDetallePanelsState> {
  CitaDetallePanelsCubit() : super(const CitaDetalleInfo());

  final PageController pageController = PageController();

  togglePanel(CitaDetallePanelsState stateOption) {
    if (stateOption == state) {
      return;
    }
    final index = stateOption.index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

    emit(stateOption);
  }

  void onPageChanged(int value) {
    if (value == 0) {
      emit(const CitaDetalleInfo());
    } else {
      emit(const CitaDetalleHistorial());
    }
  }
}
