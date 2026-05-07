import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lagos_brt_app/screens/tracking_screen.dart';
import '../data/dummy_data.dart';
import '../models/bus.dart';
import '../widgets/bus_card.dart';
import '../widgets/booking_bottom_sheet.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key});

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  String searchQuery = "";
  String selectedTerminal = "All Terminals";

  List<Bus> get filteredBuses {
    return dummyBuses.where((bus) {
      final matchesSearch = bus.route.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesTerminal = selectedTerminal == "All Terminals" || bus.terminal == selectedTerminal;
      return matchesSearch && matchesTerminal;
    }).toList();
  }

  void _showBookingSheet(Bus bus) {
    if (bus.isBooked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => TrackingScreen(bus: bus)),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingBottomSheet(bus: bus),
    );
  }

  void _showFilterSheet() {
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
              Text('Filter by Terminal', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ["All Terminals", "Ikorodu Terminal", "Oshodi Interchange", "TBS Terminal", "Ajah Terminal"]
                    .map((terminal) {
                  final isSelected = selectedTerminal == terminal;
                  return ChoiceChip(
                    label: Text(terminal),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => selectedTerminal = terminal);
                      Navigator.pop(context);
                    },
                    selectedColor: const Color(0xFF008751),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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
                          Text(
                            'Good Morning,',
                            style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 16),
                          ),
                          Text(
                            'Where are you going?',
                            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=lagos'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (val) => setState(() => searchQuery = val),
                          decoration: InputDecoration(
                            hintText: 'Search routes...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _showFilterSheet,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF008751),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.tune, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: filteredBuses.length,
                itemBuilder: (context, index) {
                  final bus = filteredBuses[index];
                  return BusCard(
                    bus: bus,
                    onBook: () => _showBookingSheet(bus),
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
