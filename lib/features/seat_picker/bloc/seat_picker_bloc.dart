import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticket_booking_app/core/hive_service/hive_db.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';

part 'seat_picker_event.dart';
part 'seat_picker_state.dart';

class SeatPickerBloc extends Bloc<SeatPickerEvent, SeatPickerState> {
  SeatPickerBloc() : super(SeatPickerInitial()) {
    on<SeatPickerInitialFetchEvent>(
      (event, emit) async {
        emit(SeatPickerLoadingState());
        final data = await HiveService.seaterInit(event.seaterId);
        emit(SeatPickerLoadedState(data: data));
      },
    );

    on<SeatSelectionUpdationEvent>(
      (event, emit) async {
        emit(SeatPickerLoadingState());
        final seatList =
            await HiveService.updataSeatReserv(event.list, event.key);
        emit(SeatSelectionUpdatedState());
        emit(SeatPickerLoadedState(data: seatList));
      },
    );
  }
}
