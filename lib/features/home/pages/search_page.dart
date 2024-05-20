import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/components/dotted_line.dart';
import 'package:ticket_booking_app/features/home/components/search_textfield.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';
import 'package:ticket_booking_app/features/home/db/ticket_mock_data.dart';
import 'package:ticket_booking_app/features/home/model/airport_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.isFrom});
  final bool isFrom;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AirportModel> airplaneList = airports;
  final fromTextController = TextEditingController();
  final toTextController = TextEditingController();
  final focusNodeFrom = FocusNode();
  final focusNodeTo = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.isFrom
          ? FocusScope.of(context).requestFocus(focusNodeFrom)
          : FocusScope.of(context).requestFocus(focusNodeTo);
    });
    super.initState();
  }

  void textFieldState(String str) {
    setState(() {
      airplaneList = airports.where((element) {
        final city = element.cityName.toLowerCase();
        final port = element.airPortName.toLowerCase();

        return city.contains(str.toLowerCase()) ||
            port.contains(str.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserTicketCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchInputField(
                      focusNode: focusNodeFrom,
                      controller: toTextController,
                      onChanged: (val) {
                        textFieldState(val);
                      },
                      fromOrTo: 'From',
                      isFrom: true,
                      hintText: widget.isFrom
                          ? 'Enter city name/ airport name'
                          : cubit.state.departForm,
                      containsValue: !widget.isFrom,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              SearchInputField(
                focusNode: focusNodeTo,
                controller: toTextController,
                onChanged: (val) {
                  textFieldState(val);
                },
                fromOrTo: 'To',
                isFrom: false,
                hintText: widget.isFrom
                    ? cubit.state.departTo
                    : 'Enter city name/ airport name',
                containsValue: widget.isFrom,
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text('Airports List'),
                  SizedBox(width: 5),
                  Expanded(child: MySeparator()),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: airplaneList.isEmpty
                    ? const Center(
                        child: Text('No result found'),
                      )
                    : ListView.builder(
                        itemCount: airplaneList.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: InkWell(
                              onTap: () {
                                final cityName = airplaneList[index].cityName;
                                focusNodeFrom.hasFocus
                                    ? cubit.departFromPlaceUpdate(cityName)
                                    : cubit.departToPlaceUpdate(cityName);

                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 20),
                                // margin: const EdgeInsets.only(bottom: 13),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.location_city_sharp,
                                                size: 15),
                                            const SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  airplaneList[index].cityName,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                Text(airplaneList[index]
                                                    .airPortName),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          airplaneList[index].codeName,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
