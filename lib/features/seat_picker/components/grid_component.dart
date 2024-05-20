import 'package:flutter/material.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';
import 'package:ticket_booking_app/features/seat_picker/components/seat_component.dart';

class SeatGridView extends StatelessWidget {
  const SeatGridView({
    super.key,
    required this.height,
    required this.width,
    required this.classType,
    required this.seatSelector,
  });

  final double height;
  final double width;
  final List<SeatModel> classType;
  final void Function(SeatModel seat) seatSelector;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.20,
      width: width * 0.16,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemBuilder: (context, index) {
            final seat = classType[index];

            return Seat(
              onTap: () => seatSelector(seat),
              seateName: seat.seatName,
              isSelected: seat.isSelected,
              isbooked: seat.isOccupied,
            );
          }),
    );
  }
}
