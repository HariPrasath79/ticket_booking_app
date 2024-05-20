import 'package:ticket_booking_app/core/models/seat_model.dart';

class UserTicketModel {
  String departForm;
  String departTo;
  DateTime departDate;
  int passengersCount;
  int adultCount;
  int infantCount;
  int childrenCount;
  List<SeatModel> selectedSeats;
  String departureTime;
  String arrivalTime;
  String flightName;
  String seaterId;

  UserTicketModel({
    required this.departForm,
    required this.departTo,
    required this.departDate,
    required this.passengersCount,
    required this.adultCount,
    required this.childrenCount,
    required this.infantCount,
    this.selectedSeats = const [],
    this.departureTime = '',
    this.arrivalTime = '',
    this.flightName = '',
    this.seaterId = 'ind',
  });

  UserTicketModel copyWith({
    String? departForm,
    String? departTo,
    DateTime? departDate,
    int? passengersCount,
    int? adultCount,
    int? infantCount,
    int? childrenCount,
    List<SeatModel>? selectedSeats,
    String? departureTime,
    String? arrivalTime,
    String? flightName,
    String? seaterId,
  }) {
    return UserTicketModel(
      departForm: departForm ?? this.departForm,
      departTo: departTo ?? this.departTo,
      departDate: departDate ?? this.departDate,
      passengersCount: passengersCount ?? this.passengersCount,
      adultCount: adultCount ?? this.adultCount,
      childrenCount: childrenCount ?? this.childrenCount,
      infantCount: infantCount ?? this.infantCount,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      flightName: flightName ?? this.flightName,
      seaterId: seaterId ?? this.seaterId,
    );
  }
}
