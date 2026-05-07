import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bus.dart';

class TrackingScreen extends StatefulWidget {
  final Bus bus;
  const TrackingScreen({super.key, required this.bus});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  double busProgress = 0.4; // 0.0 to 1.0 simulation

  @override
  void initState() {
    super.initState();
    // Simulate bus movement
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => busProgress = 0.45);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map View using the generated asset
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_ui.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Header Overlay
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 10),
                      const SizedBox(width: 8),
                      Text('Live Tracking', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(width: 44), // Spacer
              ],
            ),
          ),

          // Simulation of Road Activities (Alerts)
          Positioned(
            top: 140,
            left: 20,
            child: _buildRoadActivityAlert(
              'Accident at Surulere',
              'Expect slight delays on Route ${widget.bus.id}',
              Colors.red,
            ),
          ),

          Positioned(
            top: 220,
            left: 20,
            child: _buildRoadActivityAlert(
              'Major Traffic: Oshodi',
              '20 min additional wait time',
              Colors.orange,
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
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF008751).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.directions_bus, color: Color(0xFF008751), size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bus.id,
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Arriving in 12 mins',
                              style: GoogleFonts.outfit(color: Colors.green, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.call, color: Color(0xFF008751)),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  _buildLocationRow(Icons.my_location, 'Your Location', 'Maryland Interchange'),
                  const SizedBox(height: 12),
                  _buildLocationRow(Icons.location_on, 'BRT Current Location', 'Ikorodu Road (Near Anthony)'),
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
                      child: const Text('Cancel Booking', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadActivityAlert(String title, String subtitle, Color color) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(subtitle, style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: icon == Icons.my_location ? Colors.blue : const Color(0xFF008751), size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12)),
            Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
