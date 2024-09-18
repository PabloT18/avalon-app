import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show Curves, PageController;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_navigation_state.dart';

// Estado del PageView con el PageController
class NavigationCubit extends Cubit<int> {
  final PageController pageController = PageController(initialPage: 1);

  NavigationCubit() : super(1);

  // Método para cambiar la página
  void setPage(int page) {
    pageController.jumpToPage(page);
    // pageController.animateToPage(page,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    emit(page);
  }

  void onPageChanged(int page) {
    emit(page);
  }

  @override
  Future<void> close() {
    // Asegurarse de liberar los recursos del PageController
    pageController.dispose();
    return super.close();
  }
}
