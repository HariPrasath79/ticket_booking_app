import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TravellerCounter extends StatelessWidget {
  const TravellerCounter(
      {super.key,
      required this.category,
      required this.age,
      required this.decrementOnTap,
      required this.incrementOnTap,
      required this.count});
  final String category;
  final String age;
  final int count;
  final void Function()? decrementOnTap;
  final void Function()? incrementOnTap;

  Widget incrementDecrementCard() {
    return SizedBox(
      width: 150,
      height: 50,
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: decrementOnTap,
                child: SizedBox(
                  height: double.maxFinite,
                  child: Icon(
                    CupertinoIcons.minus,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(count.toString()),
            ),
            Expanded(
              child: InkWell(
                onTap: incrementOnTap,
                child: SizedBox(
                  height: double.maxFinite,
                  child: Icon(
                    CupertinoIcons.plus,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: '$category    ',
              style: const TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: age,
                  style: const TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 13,
                    color: Color.fromARGB(255, 101, 101, 101),
                  ),
                ),
                TextSpan(
                  text: '\n on the day of travel',
                  style: TextStyle(
                      fontFamily: 'raleway',
                      fontSize: 13,
                      color: Colors.grey[500]),
                ),
              ]),
        ),
        incrementDecrementCard(),
      ],
    );
  }
}
