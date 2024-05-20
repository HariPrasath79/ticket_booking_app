import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/dotted_line.dart';

class FlightTicketCard extends StatelessWidget {
  const FlightTicketCard({
    super.key,
    required this.planeName,
    required this.departFrom,
    required this.departTo,
    required this.travelDuration,
    required this.departTime,
    required this.arrivalTime,
    required this.ecoPrice,
    required this.onTap,
  });
  final String planeName;
  final String departFrom;
  final String departTo;
  final String travelDuration;
  final String departTime;
  final String arrivalTime;
  final String ecoPrice;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // highlightColor: Colors.amber,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.airplane,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    planeName,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: departTime,
                          children: [
                            TextSpan(
                                text: '\n $departFrom',
                                style: const TextStyle(fontSize: 13))
                          ],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Text(travelDuration),
                            const SizedBox(width: 100, child: MySeparator()),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: arrivalTime,
                          children: [
                            TextSpan(
                                text: '\n $departTo',
                                style: const TextStyle(fontSize: 13))
                          ],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 5, child: MySeparator()),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const VerticalDivider(
                          width: 5,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        RichText(
                          text: TextSpan(
                            text: '₹ $ecoPrice',
                            children: const [
                              TextSpan(
                                  text: '\n per ticket',
                                  style: TextStyle(fontSize: 13))
                            ],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
