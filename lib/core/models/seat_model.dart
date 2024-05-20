import 'package:hive/hive.dart';

part 'seat_model.g.dart';

@HiveType(typeId: 0)
class SeatModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String seatName;

  @HiveField(2)
  bool isOccupied;

  @HiveField(3)
  bool isSelected;

  @HiveField(4)
  final String side;

  @HiveField(5)
  final String classCategory;

  @HiveField(6)
  final double price;

  SeatModel({
    required this.id,
    required this.seatName,
    required this.isOccupied,
    required this.isSelected,
    required this.side,
    required this.classCategory,
    required this.price,
  });
}
