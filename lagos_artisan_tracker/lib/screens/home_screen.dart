import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../models/artisan.dart';
import '../widgets/artisan_card.dart';
import 'tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<Artisan> get filteredArtisans {
    return dummyArtisans.where((artisan) {
      final matchesSearch = artisan.name.toLowerCase().contains(searchQuery.toLowerCase()) || 
                          artisan.location.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == "All" || artisan.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _handleBooking(Artisan artisan) {
    if (artisan.isBooked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TrackingScreen(artisan: artisan)),
      );
      return;
    }
    
    // Simulate booking
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Confirm Booking', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(radius: 30, backgroundImage: AssetImage(artisan.imagePath)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(artisan.name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(artisan.category, style: GoogleFonts.outfit(color: const Color(0xFF008751))),
                    ],
                  ),
                ],
              ),
              const Divider(height: 40),
              _buildInfoRow('Estimated Arrival', '15 - 25 mins'),
              _buildInfoRow('Hourly Rate', '₦${artisan.hourlyRate.toInt()}'),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TrackingScreen(artisan: artisan)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008751),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirm & Track', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.outfit(color: Colors.grey[600])),
          Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lagos, Nigeria', style: GoogleFonts.outfit(color: const Color(0xFF008751), fontWeight: FontWeight.bold)),
                          Text('Find an Artisan', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    onChanged: (val) => setState(() => searchQuery = val),
                    decoration: InputDecoration(
                      hintText: 'Search plumber, electrician...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ["All", "Plumber", "Electrician", "Carpenter", "Painter"].map((cat) {
                        final isSelected = selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() => selectedCategory = cat),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF008751) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filteredArtisans.length,
                itemBuilder: (context, index) {
                  return ArtisanCard(
                    artisan: filteredArtisans[index],
                    onBook: () => _handleBooking(filteredArtisans[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
