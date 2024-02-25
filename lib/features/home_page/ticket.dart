class Ticket {
  final String type;
  final String ticketId;
  final String date;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final int points;

  Ticket({
    required this.type,
    required this.ticketId,
    required this.date,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.points,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      type: json['type'] as String,
      ticketId: json['ticketId'] as String,
      date: json['date'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      points: json['points'] as int,
    );
  }
}
