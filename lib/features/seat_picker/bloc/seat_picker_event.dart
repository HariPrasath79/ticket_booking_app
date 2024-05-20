part of 'seat_picker_bloc.dart';

@immutable
sealed class SeatPickerEvent {}

class SeatPickerInitialFetchEvent extends SeatPickerEvent {
  final String seaterId;

  SeatPickerInitialFetchEvent({required this.seaterId});
}

class SeatSelectionUpdationEvent extends SeatPickerEvent {
  final List<SeatModel> list;
  final String key;

  SeatSelectionUpdationEvent({required this.list, required this.key});
}
