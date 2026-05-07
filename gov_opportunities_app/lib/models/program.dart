class Program {
  final String title;
  final String organizer;
  final String category;
  final String status; // Ongoing, Upcoming, Past
  final String mode; // Physical, Virtual, Hybrid
  final String state;
  final String date;
  final String deadline;
  final String description;
  final String eligibility;
  final String imagePath;
  final String registrationLink;

  Program({
    required this.title,
    required this.organizer,
    required this.category,
    required this.status,
    required this.mode,
    required this.state,
    required this.date,
    required this.deadline,
    required this.description,
    required this.eligibility,
    required this.imagePath,
    required this.registrationLink,
  });
}
