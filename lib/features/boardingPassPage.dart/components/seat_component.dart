import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  const SeatWidget(
      {super.key, required this.seatName, required this.seatClass});
  final String seatName;
  final String seatClass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(seatName)),
        ),
        Text(seatClass)
      ],
    );
  }
}
