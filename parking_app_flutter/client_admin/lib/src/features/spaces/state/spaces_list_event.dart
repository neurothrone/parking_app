part of 'spaces_list_bloc.dart';

sealed class SpacesListEvent {
  const SpacesListEvent();
}

final class SpacesListLoad extends SpacesListEvent {}

final class SpacesListAddItem extends SpacesListEvent {
  const SpacesListAddItem({required this.space});

  final ParkingSpace space;
}

final class SpacesListDeleteItem extends SpacesListEvent {
  const SpacesListDeleteItem({required this.id});

  final int id;
}

final class SpacesListUpdate extends SpacesListEvent {}