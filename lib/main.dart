import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_booking_app/core/hive_service/hive_db.dart';
import 'package:ticket_booking_app/features/boardingPassPage.dart/boarding_pass_page.dart';
import 'package:ticket_booking_app/features/flight_list/flight_list_page.dart';
import 'package:ticket_booking_app/features/home/cubit/travellers_count_cubit.dart';
import 'package:ticket_booking_app/features/home/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.hiveInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserTicketCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const HomePage(),
          '/flight_list': (_) => const FlightListPage(),
          '/boarding_pass': (_) => const BoardingPassPage(),
        },
        theme: ThemeData(
          fontFamily: 'poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
