import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/artisan.dart';

class TrackingScreen extends StatelessWidget {
  final Artisan artisan;
  const TrackingScreen({super.key, required this.artisan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_ui.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),

          // Status Overlay
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.circle, color: Colors.green, size: 12),
                  const SizedBox(width: 8),
                  Text('On the way', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Bottom Detail Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 30, backgroundImage: AssetImage(artisan.imagePath)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(artisan.name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                            Text('ETA: 18 mins', style: GoogleFonts.outfit(color: const Color(0xFF008751), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildActionIcon(Icons.call, () => _launchUrl('tel:+2348012345678')),
                          const SizedBox(width: 12),
                          _buildActionIcon(Icons.message, () => _launchUrl('sms:+2348012345678')),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  _buildLocationInfo(Icons.my_location, 'Your Residence', 'Lekki Phase 1, Gate 2'),
                  const SizedBox(height: 16),
                  _buildLocationInfo(Icons.person_pin_circle, 'Artisan Location', 'Crossing Falomo Bridge'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008751),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View Job Details', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
        child: Icon(icon, color: const Color(0xFF008751)),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  Widget _buildLocationInfo(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF008751), size: 24),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 12)),
            Text(subtitle, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
