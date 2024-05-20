import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_booking_app/core/components/elevated_button.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/dotted_line.dart';
import 'package:ticket_booking_app/features/flight_list/components/flight_ticket_card.dart';
import 'package:ticket_booking_app/features/flight_list/flight_list_page.dart';
import 'package:ticket_booking_app/features/home/components/bottom_sheet.dart';
import 'package:ticket_booking_app/features/home/components/flight_details_card.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';
import 'package:ticket_booking_app/features/home/db/ticket_mock_data.dart';
import 'package:ticket_booking_app/features/home/model/user_ticket_model.dart';
import 'package:ticket_booking_app/features/home/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final thisYear = DateTime.now().year;
  final thisMonth = DateTime.now().month;
  int count = 1;
  int totaltravelers = 1;
  DateTime flightDate = DateTime.now();

  final recommended =
      flightList.skipWhile((flight) => flight.from == 'Mumbai').toList();

  String dateFormater(DateTime date) {
    final formatedDate = DateFormat.yMMMEd().format(date);
    return formatedDate;
  }

  Future<void> selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(
        thisYear,
        thisMonth,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        thisYear,
        12,
      ),
      initialDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        flightDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserTicketCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BOOK AIR NOW',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Travel with peace',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<UserTicketCubit, UserTicketModel>(
                bloc: cubit,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Column(
                      children: [
                        FlightDetailsCard(
                          flightIcon: Icon(Icons.flight_takeoff),
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SearchPage(
                                      isFrom: true,
                                    )));
                          },
                          title: 'From',
                          subTitle: cubit.state.departForm,
                          width: double.maxFinite,
                        ),
                        SizedBox(height: 15),
                        FlightDetailsCard(
                          flightIcon: Icon(Icons.flight_land),
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SearchPage(
                                      isFrom: false,
                                    )));
                          },
                          title: 'To',
                          subTitle: cubit.state.departTo,
                          width: double.maxFinite,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: FlightDetailsCard(
                                flightIcon: Icon(CupertinoIcons.calendar),
                                ontap: () async {
                                  await selectDate();
                                  cubit.departDateUpdate(flightDate);
                                },
                                title: 'Depart',
                                subTitle: dateFormater(cubit.state.departDate),
                                fontSize: 15,
                                dropDownIcon: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const SizedBox(width: 5),
                            FlightDetailsCard(
                              flightIcon: const Icon(CupertinoIcons.person),
                              title: 'Travellers',
                              subTitle: '${cubit.state.passengersCount}',
                              fontSize: 15,
                              ontap: () async {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const LinearBorder(),
                                    builder: (_) {
                                      return BottomSheetCard(
                                        adultCount: cubit.state.adultCount,
                                        childrenCount:
                                            cubit.state.childrenCount,
                                        totalCount: cubit.state.passengersCount,
                                        infantCount: cubit.state.infantCount,
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            height: 45,
                            width: double.maxFinite,
                            child: SubmitButton(
                              text: 'Search Ticket',
                              onPressed: () {
                                if (cubit.state.departForm ==
                                    cubit.state.departTo) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'From & to field should not be same')),
                                      snackBarAnimationStyle: AnimationStyle());
                                } else if (cubit.state.passengersCount == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Select atleast 1 traveller')),
                                      snackBarAnimationStyle: AnimationStyle());
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const FlightListPage()));
                                }
                              },
                            )),
                        const SizedBox(height: 15),
                        const Row(
                          children: [
                            Text(
                              'Recommended',
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(
                              child: MySeparator(),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: recommended.length,
                      itemBuilder: (_, index) {
                        final item = recommended[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FlightTicketCard(
                              planeName: item.flightName,
                              departFrom: item.from,
                              departTo: item.onTo,
                              travelDuration: item.travelTime,
                              departTime: item.departureTime,
                              arrivalTime: item.arraivalTime,
                              ecoPrice: item.ecoTicketPrice.toString(),
                              onTap: () {}),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
