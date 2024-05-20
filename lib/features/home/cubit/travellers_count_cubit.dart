import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';
import 'package:ticket_booking_app/features/home/db/ticket_mock_data.dart';
import 'package:ticket_booking_app/features/home/model/user_ticket_model.dart';

part 'travellers_count_state.dart';

class UserTicketCubit extends Cubit<UserTicketModel> {
  UserTicketCubit() : super(userTicketModel);

  void passengerCountUpdate(int count) {
    final newState = state.copyWith(passengersCount: count);
    emit(newState);
  }

  void departDateUpdate(DateTime date) {
    final newstate = state.copyWith(departDate: date);
    emit(newstate);
  }

  void departFromPlaceUpdate(String place) {
    final newstate = state.copyWith(departForm: place);
    emit(newstate);
  }

  void departToPlaceUpdate(String place) {
    final newstate = state.copyWith(departTo: place);
    emit(newstate);
  }

  void ageCategoryUpdate(
      {required int adult, required int children, required int infant}) {
    final newstate = state.copyWith(
        adultCount: adult, childrenCount: children, infantCount: infant);
    emit(newstate);
  }

  void selectedSeatsUpdate({
    required List<SeatModel> list,
  }) {
    final newstate = state.copyWith(
      selectedSeats: list,
    );
    emit(newstate);
  }

  void flightDetailsUpdate({
    required String departTime,
    required String arrivalTime,
    required String flightName,
    required String seaterId,
  }) {
    final newstate = state.copyWith(
      departureTime: departTime,
      arrivalTime: arrivalTime,
      flightName: flightName,
      seaterId: seaterId,
    );
    emit(newstate);
  }
}
