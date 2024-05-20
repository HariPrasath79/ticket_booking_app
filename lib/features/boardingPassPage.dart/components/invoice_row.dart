import 'package:flutter/material.dart';

class InvoiceRow extends StatelessWidget {
  const InvoiceRow({
    super.key,
    required this.fontStyle,
    required this.leftHeader,
    required this.leftString,
    required this.rightHeader,
    required this.rightString,
  });
  final TextStyle? fontStyle;
  final String rightHeader;
  final String leftHeader;
  final String rightString;
  final String leftString;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightHeader,
              style: fontStyle,
            ),
            Text(
              rightString,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftHeader,
              style: fontStyle,
            ),
            Text(
              leftString,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        )
      ],
    );
  }
}
