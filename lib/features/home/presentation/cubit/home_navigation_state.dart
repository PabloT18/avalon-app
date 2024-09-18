part of 'home_navigation_cubit.dart';

sealed class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

final class HomeNavigationInitial extends HomeNavigationState {}
