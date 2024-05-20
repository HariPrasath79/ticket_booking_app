import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_booking_app/core/models/seat_model.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';
import 'package:ticket_booking_app/features/seat_picker/bloc/seat_picker_bloc.dart';
import 'package:ticket_booking_app/features/seat_picker/components/custom_painter.dart';
import 'package:ticket_booking_app/features/seat_picker/components/grid_component.dart';

class SeatPickerPage extends StatefulWidget {
  const SeatPickerPage({super.key});

  @override
  State<SeatPickerPage> createState() => _SeatPickerPageState();
}

class _SeatPickerPageState extends State<SeatPickerPage> {
  List<SeatModel> selectedSeats = [];
  double _bill = 0;
  int _selectedBusinessClass = 0;
  int _selectedEconomyClass = 0;
  String fromPlace = 'Chennai';
  String toPlace = 'Delhi';

  // final selectedSeat = Queue<SeatModel>();

  final bloc = SeatPickerBloc();
  late final UserTicketCubit cubit;

  // @override
  // void initState() {
  //   super.initState();
  //   bloc.add(SeatPickerInitialFetchEvent());
  //   print('init called');
  // }

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<UserTicketCubit>(context);
    bloc.add(SeatPickerInitialFetchEvent(
      seaterId: cubit.state.seaterId,
    ));

    super.didChangeDependencies();
  }

  void _seaterState(SeatModel seat) {
    setState(() {
      !seat.isOccupied ? seat.isSelected = !seat.isSelected : null;

      if (!seat.isOccupied) {
        if (seat.isSelected) {
          if (selectedSeats.length >= cubit.state.passengersCount) {
            selectedSeats[0].isSelected = false;
            _bill = _bill - selectedSeats[0].price;
            selectedSeats[0].classCategory == 'business'
                ? _selectedBusinessClass--
                : _selectedEconomyClass--;
            selectedSeats.removeAt(0);
          }

          _bill = _bill + seat.price;
          selectedSeats.add(seat);
          seat.classCategory == 'business'
              ? _selectedBusinessClass++
              : _selectedEconomyClass++;
        } else {
          selectedSeats.remove(seat);
          _bill = _bill - seat.price;
          seat.classCategory == 'business'
              ? _selectedBusinessClass--
              : _selectedEconomyClass--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          if (_bill == 0 ||
              selectedSeats.length < cubit.state.passengersCount) {
            var snackbar = SnackBar(
                content: const Text('Please select the seat first'),
                action: SnackBarAction(
                    label: 'ok',
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                    }));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          } else {
            if (selectedSeats.isNotEmpty) {
              cubit.selectedSeatsUpdate(list: selectedSeats);

              Navigator.of(context).popAndPushNamed('/boarding_pass');
              bloc.add(SeatSelectionUpdationEvent(
                  list: selectedSeats, key: cubit.state.seaterId));
              _bill = 0;
              _selectedBusinessClass = 0;
              _selectedEconomyClass = 0;
              selectedSeats = [];
            }
          }
        },
        icon: Icon(
          CupertinoIcons.tickets,
          color: _bill == 0 ? Colors.grey[700] : null,
        ),
        label: Text(
          'Checkout',
          style: TextStyle(
              fontSize: 15, color: _bill == 0 ? Colors.grey[700] : null),
        ),
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(_bill == 0 ? Colors.grey[300] : null),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            elevation: _bill > 0 ? const WidgetStatePropertyAll(10) : null,
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15, horizontal: 15))),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fromPlace),
            const SizedBox(width: 15),
            const Icon(
              CupertinoIcons.airplane,
            ),
            const SizedBox(width: 15),
            Text(toPlace),
          ],
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<SeatPickerBloc, SeatPickerState>(
        bloc: bloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SeatPickerLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is SeatPickerLoadedState) {
            final data = state.data;
            final businessLeft = data
                .where((seat) =>
                    seat.classCategory == 'business' && seat.side == 'L')
                .toList();
            final businessRight = data
                .where((seat) =>
                    seat.classCategory == 'business' && seat.side == 'R')
                .toList();
            final economyRight = data
                .where((seat) =>
                    seat.classCategory == 'economy' && seat.side == 'R')
                .toList();
            final economyLeft = data
                .where((seat) =>
                    seat.classCategory == 'economy' && seat.side == 'L')
                .toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 231, 222, 247),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text('Occupied'),
                      const SizedBox(width: 10),
                      Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 220, 201, 255),
                          border: Border.all(color: Colors.black54, width: 1.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text('Available'),
                      const SizedBox(width: 10),
                      Container(
                        height: 23,
                        width: 23,
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text('Selected'),
                    ],
                  ),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 2,
                        child: CustomPaint(
                          size: Size(double.maxFinite, screenht * 0.7),
                          painter: RPSCustomPainter(),
                        ),
                      ),
                      Positioned(
                        left: screenwt * 0.313,
                        top: screenht * 0.09,
                        child: Column(
                          children: [
                            const Text("Business Class"),
                            SizedBox(height: screenht * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SeatGridView(
                                    height: screenht,
                                    width: screenwt,
                                    classType: businessLeft,
                                    seatSelector: _seaterState),
                                SizedBox(width: screenwt * 0.05),
                                SeatGridView(
                                    height: screenht,
                                    width: screenwt,
                                    classType: businessRight,
                                    seatSelector: _seaterState),
                              ],
                            ),
                            // SizedBox(height: screenht * 0.01),
                            const Text("Economy Class"),
                            SizedBox(height: screenht * 0.007),
                            Row(
                              children: [
                                SeatGridView(
                                    height: screenht,
                                    width: screenwt,
                                    classType: economyLeft,
                                    seatSelector: _seaterState),
                                SizedBox(width: screenwt * 0.05),
                                SeatGridView(
                                    height: screenht,
                                    width: screenwt,
                                    classType: economyRight,
                                    seatSelector: _seaterState),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Text(
                            'Total: $_bill',
                            style: const TextStyle(fontSize: 22),
                          ),
                          Text(
                            'Business class x$_selectedBusinessClass',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Economic class x$_selectedEconomyClass',
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      )),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Something went wrong, try again..'),
          );
        },
      ),
    );
  }
}
