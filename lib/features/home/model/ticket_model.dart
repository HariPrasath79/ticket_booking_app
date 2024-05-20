class TicketModel {
  final String from;
  final String onTo;
  final String flightName;
  final List<int> availability;
  final String seaterlId;
  final String departureTime;
  final String arraivalTime;
  final String travelTime;
  final double ecoTicketPrice;
  final double bnsTicketPrice;

  TicketModel({
    required this.from,
    required this.onTo,
    required this.flightName,
    required this.availability,
    required this.seaterlId,
    required this.departureTime,
    required this.arraivalTime,
    required this.travelTime,
    required this.bnsTicketPrice,
    required this.ecoTicketPrice,
  });
}
