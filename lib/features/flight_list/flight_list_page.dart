import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ticket_booking_app/features/flight_list/components/flight_ticket_card.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';
import 'package:ticket_booking_app/features/home/db/ticket_mock_data.dart';
import 'package:ticket_booking_app/features/home/model/ticket_model.dart';
import 'package:ticket_booking_app/features/seat_picker/seat_picker_page.dart';

class FlightListPage extends StatefulWidget {
  const FlightListPage({super.key});

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  CalendarFormat _calenderFormat = CalendarFormat.week;
  late DateTime today;
  late final UserTicketCubit cubitBloc;
  DateTime firstDate = DateTime.now();
  List<TicketModel> flightData = [];
  // late List<TicketModel> testList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      cubitBloc = BlocProvider.of<UserTicketCubit>(context);

      today = cubitBloc.state.departDate;

      flightData = flightList
          .where((item) =>
              item.from == cubitBloc.state.departForm &&
              item.onTo == cubitBloc.state.departTo)
          .toList();
      // flightData = flightList;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onDaySelected(DateTime day, DateTime focusday) {
      setState(() {
        today = day;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Flights'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          TableCalendar(
            currentDay: today,
            focusedDay: today,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week'
            },
            rowHeight: 45,
            headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                    color: Colors.grey,
                    backgroundBlendMode: BlendMode.darken,
                    borderRadius: BorderRadius.circular(18))),
            onFormatChanged: (format) {
              setState(() {
                _calenderFormat = format;
              });
            },
            daysOfWeekHeight: 27,
            calendarFormat: _calenderFormat,
            firstDay: firstDate,
            lastDay: firstDate.add(Duration(days: 60)),
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
          ),
          flightData.isEmpty
              ? const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No flights available'),
                    ],
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: flightData.length,
                        itemBuilder: (context, index) {
                          final data = flightData[index];
                          final planeName = data.flightName;
                          final departTime = data.departureTime;
                          final arrrivalTime = data.arraivalTime;
                          final departFrom = data.from;
                          final travelDuration = data.travelTime;
                          final departTo = data.onTo;
                          final seaterId = data.seaterlId;
                          final ecoPrice =
                              data.ecoTicketPrice.floor().toString();
                          return SizedBox(
                            width: double.maxFinite,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: FlightTicketCard(
                                onTap: () {
                                  cubitBloc.flightDetailsUpdate(
                                      departTime: departTime,
                                      arrivalTime: arrrivalTime,
                                      seaterId: seaterId,
                                      flightName: planeName);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const SeatPickerPage()));
                                },
                                planeName: planeName,
                                departFrom: departFrom,
                                departTo: departTo,
                                travelDuration: travelDuration,
                                departTime: departTime,
                                arrivalTime: arrrivalTime,
                                ecoPrice: ecoPrice,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
        ],
      ),
    );
  }
}
