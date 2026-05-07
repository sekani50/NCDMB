import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialSelectedState;
  final List<String> initialSelectedFilters;
  final Function(String, List<String>) onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialSelectedState,
    required this.initialSelectedFilters,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedState;
  late List<String> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedState = widget.initialSelectedState;
    selectedFilters = List.from(widget.initialSelectedFilters);
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isSelected = selectedFilters.contains(opt);
            return FilterChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedFilters.add(opt);
                  } else {
                    selectedFilters.remove(opt);
                  }
                });
              },
              selectedColor: const Color(0xFF008751).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF008751),
              labelStyle: GoogleFonts.outfit(
                color: isSelected ? const Color(0xFF008751) : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: BorderSide(
                color: isSelected ? const Color(0xFF008751) : Colors.grey[300]!,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('State', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: selectedState,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            items: [
              "All States",
              "Abuja",
              "Lagos",
              "Kano",
              "Rivers",
              "Kaduna",
            ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) {
              setState(() => selectedState = val!);
            },
          ),
          const SizedBox(height: 24),
          _buildFilterSection('Status', ['Ongoing', 'Upcoming', 'Past']),
          const SizedBox(height: 24),
          _buildFilterSection('Mode', ['Physical', 'Virtual', 'Hybrid']),
          const Spacer(),
          Row(
            children: [
              if (selectedState != "All States" || selectedFilters.isNotEmpty) ...[
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedState = "All States";
                          selectedFilters.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Clear Filters'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(selectedState, selectedFilters);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008751),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
