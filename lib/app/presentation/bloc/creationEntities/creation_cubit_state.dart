part of 'creation_cubit_cubit.dart';

enum ItemType { emergencia, reclamaciones, citas }

sealed class CreationState extends Equatable {
  const CreationState();

  @override
  List<Object> get props => [];
}

class CreationInitial extends CreationState {}

class ItemCreated extends CreationState {
  final ItemType itemType; // Enum or type indicating what was created

  const ItemCreated(this.itemType);
}
