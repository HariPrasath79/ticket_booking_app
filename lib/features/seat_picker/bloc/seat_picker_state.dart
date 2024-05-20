part of 'seat_picker_bloc.dart';

@immutable
sealed class SeatPickerState {}

final class SeatPickerInitial extends SeatPickerState {}

final class SeatPickerLoadingState extends SeatPickerState {}

final class SeatPickerLoadedState extends SeatPickerState {
  final List<SeatModel> data;

  SeatPickerLoadedState({required this.data});
}

final class SeatSelectionUpdatedState extends SeatPickerState {}
