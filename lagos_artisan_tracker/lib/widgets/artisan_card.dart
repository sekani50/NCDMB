import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/artisan.dart';
import '../screens/tracking_screen.dart';

class ArtisanCard extends StatelessWidget {
  final Artisan artisan;
  final VoidCallback onBook;

  const ArtisanCard({super.key, required this.artisan, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                  tag: artisan.id,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(artisan.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            artisan.name,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (artisan.isBooked)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF008751),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.white, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Booked',
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text(
                        artisan.category,
                        style: GoogleFonts.outfit(color: const Color(0xFF008751), fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text('${artisan.rating}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          Text('(${artisan.jobsCompleted} jobs)', style: GoogleFonts.outfit(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    Text(artisan.location, style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 14)),
                  ],
                ),
                Text(
                  '₦${artisan.hourlyRate.toInt()}/hr',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: artisan.isAvailable || artisan.isBooked ? onBook : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: artisan.isBooked ? Colors.white : const Color(0xFF008751),
                  foregroundColor: artisan.isBooked ? const Color(0xFF008751) : Colors.white,
                  side: artisan.isBooked ? const BorderSide(color: Color(0xFF008751)) : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  artisan.isBooked ? 'Track Location' : (artisan.isAvailable ? 'Book Now' : 'Currently Busy'),
                  style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
