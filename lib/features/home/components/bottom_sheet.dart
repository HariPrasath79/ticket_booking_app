import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_booking_app/core/components/elevated_button.dart';
import 'package:ticket_booking_app/features/home/components/traveler_counter.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';

// ignore: must_be_immutable
class BottomSheetCard extends StatelessWidget {
  BottomSheetCard({
    super.key,
    required this.adultCount,
    required this.childrenCount,
    required this.infantCount,
    required this.totalCount,
    this.incrementFunction,
    this.decrementFunction,
    this.submitOnPressed,
  });
  int adultCount;
  int childrenCount;
  int infantCount;
  int totalCount;
  final void Function(int count)? incrementFunction;
  final void Function(int count)? decrementFunction;
  final void Function(int count)? submitOnPressed;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        final cubit = BlocProvider.of<UserTicketCubit>(context);
        return SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                shape: const LinearBorder(side: BorderSide.none),
                elevation: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        CupertinoIcons.xmark,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Select Travellers',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, left: 10, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add number of Travellers',
                            style: TextStyle(
                                fontFamily: 'raleway',
                                color: Colors.grey[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 15),
                          TravellerCounter(
                              category: 'Adult',
                              age: '12 yrs & above',
                              count: adultCount,
                              incrementOnTap: () => setState(
                                    () {
                                      adultCount++;
                                      totalCount++;
                                    },
                                  ),
                              decrementOnTap: () => setState(
                                    () {
                                      if (adultCount != 0) {
                                        adultCount--;
                                        totalCount--;
                                      }
                                    },
                                  )),
                          const SizedBox(height: 15),
                          TravellerCounter(
                              category: 'Children',
                              age: 'more than 2 years',
                              count: childrenCount,
                              incrementOnTap: () => setState(
                                    () {
                                      childrenCount++;
                                      totalCount++;
                                    },
                                  ),
                              decrementOnTap: () => setState(
                                    () {
                                      if (childrenCount != 0) {
                                        childrenCount--;
                                        totalCount--;
                                      }
                                    },
                                  )),
                          const SizedBox(height: 15),
                          TravellerCounter(
                              category: 'Infant',
                              age: 'less than 2 years',
                              count: infantCount,
                              incrementOnTap: () => setState(
                                    () {
                                      infantCount++;
                                      totalCount++;
                                    },
                                  ),
                              decrementOnTap: () => setState(
                                    () {
                                      if (infantCount != 0) {
                                        infantCount--;
                                        totalCount--;
                                      }
                                    },
                                  )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Travellers: $totalCount',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.maxFinite,
                            child: SubmitButton(
                                text: 'Submit',
                                onPressed: () {
                                  cubit.passengerCountUpdate(totalCount);
                                  cubit.ageCategoryUpdate(
                                      adult: adultCount,
                                      children: childrenCount,
                                      infant: infantCount);
                                  Navigator.of(context).pop();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
