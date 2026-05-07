class Artisan {
  final String id;
  final String name;
  final String category;
  final String location;
  final double rating;
  final int jobsCompleted;
  final String imagePath;
  final bool isAvailable;
  final bool isBooked;
  final String description;
  final double hourlyRate;

  Artisan({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.rating,
    required this.jobsCompleted,
    required this.imagePath,
    this.isAvailable = true,
    this.isBooked = false,
    required this.description,
    required this.hourlyRate,
  });
}
