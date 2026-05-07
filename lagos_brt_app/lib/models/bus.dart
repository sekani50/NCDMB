class Bus {
  final String id;
  final String route;
  final String operator;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final int availableSeats;
  final String terminal;
  final String status; // On Time, Delayed, Boarding
  final bool isBooked;

  Bus({
    required this.id,
    required this.route,
    required this.operator,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.availableSeats,
    required this.terminal,
    required this.status,
    this.isBooked = false,
  });
}
