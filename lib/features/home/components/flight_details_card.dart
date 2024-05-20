import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.ontap,
      this.width,
      this.flightIcon,
      this.isTravelers = false,
      this.fontSize = 20,
      this.dropDownIcon});
  final String subTitle;
  final String title;
  final double? width;
  final double? fontSize;
  final Widget? dropDownIcon;
  final Widget? flightIcon;
  final bool isTravelers;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(31, 133, 132, 132),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 40,
        // width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                flightIcon ?? const SizedBox(),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              child: dropDownIcon ?? const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
