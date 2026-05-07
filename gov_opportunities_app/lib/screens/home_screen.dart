import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/dummy_data.dart';
import '../models/program.dart';
import '../widgets/program_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  List<String> selectedFilters = [];
  String selectedState = "All States";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Program> get filteredPrograms {
    return dummyPrograms.where((p) {
      final matchesSearch = p.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.organizer.toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesState = selectedState == "All States" || p.state == selectedState;
      
      bool matchesFilter = true;
      if (selectedFilters.isNotEmpty) {
        matchesFilter = selectedFilters.any((f) => 
          p.status == f || p.mode == f || p.category == f
        );
      }

      return matchesSearch && matchesState && matchesFilter;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheet(
          initialSelectedState: selectedState,
          initialSelectedFilters: selectedFilters,
          onApply: (state, filters) {
            setState(() {
              selectedState = state;
              selectedFilters = filters;
              if (state == "All States" && filters.isEmpty) {
                _searchController.clear();
                searchQuery = "";
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'GovOpportunities',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold, 
            color: const Color(0xFF008751),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.tune, color: Color(0xFF008751)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search programs or agencies...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredPrograms.length,
              itemBuilder: (context, index) {
                final program = filteredPrograms[index];
                return ProgramCard(program: program);
              },
            ),
          ),
        ],
      ),
    );
  }
}
