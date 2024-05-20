import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/dotted_line.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/invoice_row.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/seat_component.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/service/ems_pdf_service.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';

class BoardingPassPage extends StatelessWidget {
  const BoardingPassPage({
    super.key,
  });

  String _dateFormater(DateTime date) {
    final formatedDate = DateFormat.yMMMMd().format(date);
    return formatedDate;
  }

  @override
  Widget build(BuildContext context) {
    final cubitBloc = BlocProvider.of<UserTicketCubit>(context);
    final flightDetails = cubitBloc.state;
    final List<SeatModel> selectedSeats = flightDetails.selectedSeats;

    const headerStyle =
        TextStyle(fontSize: 16, color: Colors.black54, fontFamily: 'poppins');

    const subHeaderStyle =
        TextStyle(color: Colors.black, fontFamily: 'poppins', fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Boarding Pass'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card.filled(
                  surfaceTintColor: Colors.deepPurple[300],
                  color: const Color.fromARGB(255, 232, 222, 249),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: flightDetails.departForm,
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n ${cubitBloc.state.departureTime}',
                                      style: headerStyle,
                                    ),
                                  ]),
                            ),
                            // Text(
                            //   flightDetails.departForm,
                            //   style: const TextStyle(
                            //       fontSize: 19, fontWeight: FontWeight.bold),
                            // ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: MySeparator(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              children: [
                                Icon(CupertinoIcons.airplane),
                                Text('2:00 Hrs')
                              ],
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                                child: MySeparator(
                              color: Colors.grey,
                            )),
                            const SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                  text: flightDetails.departTo,
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: '\n ${cubitBloc.state.arrivalTime}',
                                      style: headerStyle,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const MySeparator(
                          dashWidth: 4,
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Passengers',
                                  style: headerStyle,
                                  children: [
                                    TextSpan(
                                      text:
                                          '\n Adult x ${flightDetails.adultCount}',
                                      style: subHeaderStyle,
                                    ),
                                    TextSpan(
                                      text:
                                          '\n Children x ${flightDetails.childrenCount}',
                                      style: subHeaderStyle,
                                    ),
                                    TextSpan(
                                      text:
                                          '\n Infant x ${flightDetails.infantCount}',
                                      style: subHeaderStyle,
                                    )
                                  ]),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                      text: 'User Id',
                                      style: headerStyle,
                                      children: [
                                        TextSpan(
                                          text: '\n 0293820103',
                                          style: subHeaderStyle,
                                        ),
                                      ]),
                                ),
                                RichText(
                                  text: const TextSpan(
                                      text: 'Transaction ID',
                                      style: headerStyle,
                                      children: [
                                        TextSpan(
                                          text: '\n 728939210SLDD',
                                          style: subHeaderStyle,
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Seat Details',
                          style: headerStyle,
                        ),
                        const SizedBox(height: 5),
                        Wrap(
                          children: List.generate(
                              selectedSeats.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: SeatWidget(
                                      seatName: selectedSeats[index].seatName,
                                      seatClass:
                                          selectedSeats[index].classCategory ==
                                                  'business'
                                              ? 'B'
                                              : 'E',
                                    ),
                                  )),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: MySeparator(
                            dashWidth: 4,
                            color: Colors.black54,
                          ),
                        ),
                        InvoiceRow(
                          fontStyle: headerStyle,
                          leftHeader: 'Gate',
                          leftString: 'LY834',
                          rightHeader: 'Flight',
                          rightString: cubitBloc.state.flightName,
                        ),
                        const SizedBox(height: 15),
                        InvoiceRow(
                          fontStyle: headerStyle,
                          leftHeader: 'Terminal',
                          leftString: '3',
                          rightHeader: 'Depart',
                          rightString: _dateFormater(flightDetails.departDate),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 15.0),
                        //   child: MySeparator(
                        //     dashWidth: 7,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () async {
                    final data = await EmsPdfService.generateEMSPDF();

                    await EmsPdfService.savePdfFile('ems_pdf', data, context);
                  },
                  highlightColor: Colors.deepPurple,
                  child: Container(
                    // margin: EdgeInsets.all(0),
                    // padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.deepPurple[500]!,
                        Colors.deepPurple[300]!,
                        Colors.deepPurple[200]!
                      ]),
                      // border: Border.all(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Download Invoice',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // SizedBox(
                //   width: double.maxFinite,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //         backgroundColor:
                //             const WidgetStatePropertyAll(Colors.deepPurple),
                //         shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10)))),
                //     onPressed: () async {
                //       final data = await EmsPdfService.generateEMSPDF();

                //       await EmsPdfService.savePdfFile('ems_pdf', data, context);
                //     },
                //     child: const Text(
                //       'Download Invoice',
                //       style: TextStyle(fontSize: 18, color: Colors.white),
                //     ),
                //   ),
                // )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15)),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
