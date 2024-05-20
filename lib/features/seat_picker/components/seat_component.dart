import 'package:flutter/material.dart';

class Seat extends StatelessWidget {
  const Seat({
    super.key,
    required this.isbooked,
    required this.isSelected,
    this.onTap,
    required this.seateName,
  });
  final bool isbooked;
  final bool isSelected;
  final String seateName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color? background;
    if (isbooked) background = const Color(0xFFECE1FF);
    if (!isbooked && isSelected) background = Colors.green[400];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: background,
            border: isSelected
                ? Border.all(color: Colors.transparent, width: 0)
                : Border.all(
                    color: Colors.black,
                  ),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          seateName,
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }
}
