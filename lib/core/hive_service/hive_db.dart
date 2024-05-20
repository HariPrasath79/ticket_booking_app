import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticket_booking_app/core/models/db/seat_details.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';

class HiveService {
  // static const _seatModelKey = 'seat';
  // static late Box<SeatModel> seatBox;
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SeatModelAdapter());
  }

  static Future<List<SeatModel>> seaterInit(String seatModelKey) async {
    final seatBox = await Hive.openBox<SeatModel>(seatModelKey);
    var list = seatBox.values.toList();
    if (list.isNotEmpty) {
      return list;
    } else {
      await seatBox.addAll(seatList());
      list = seatBox.values.toList();
      return list;
    }
  }

  static Future<List<SeatModel>> updataSeatReserv(
      List<SeatModel> list, String key) async {
    final seatBox = Hive.box<SeatModel>(key);
    final selectedSeats = list;
    for (final seat in selectedSeats) {
      final newSeat = SeatModel(
        id: seat.id,
        seatName: seat.seatName,
        isOccupied: true,
        isSelected: seat.isSelected,
        side: seat.side,
        classCategory: seat.classCategory,
        price: seat.price,
      );
      await seatBox.put(seat.id, newSeat);
    }

    final seatList = seatBox.values.toList();
    return seatList;
  }
}
