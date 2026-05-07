import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bus.dart';

class BusCard extends StatelessWidget {
  final Bus bus;
  final VoidCallback onBook;

  const BusCard({super.key, required this.bus, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bus.route,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bus.operator,
                    style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bus.isBooked 
                      ? const Color(0xFF008751) 
                      : _getStatusColor(bus.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (bus.isBooked) ...[
                      const Icon(Icons.check_circle, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      bus.isBooked ? 'Booked' : bus.status,
                      style: GoogleFonts.outfit(
                        color: bus.isBooked ? Colors.white : _getStatusColor(bus.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn('Departure', bus.departureTime),
              _buildInfoColumn('Terminal', bus.terminal.split(' ')[0]),
              _buildInfoColumn('Price', '₦${bus.price.toInt()}'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus.isBooked ? 'Check-in required at terminal' : '${bus.availableSeats} seats left',
                      style: GoogleFonts.outfit(
                        color: bus.isBooked ? const Color(0xFF008751) : (bus.availableSeats < 5 ? Colors.red : Colors.green),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: bus.isBooked ? 1.0 : bus.availableSeats / 40,
                      backgroundColor: Colors.grey[200],
                      color: const Color(0xFF008751),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: bus.availableSeats > 0 || bus.isBooked ? onBook : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: bus.isBooked ? Colors.white : const Color(0xFF008751),
                  foregroundColor: bus.isBooked ? const Color(0xFF008751) : Colors.white,
                  side: bus.isBooked ? const BorderSide(color: Color(0xFF008751)) : null,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(bus.isBooked ? 'Track Bus' : 'Book Seat'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.grey, fontSize: 12)),
        Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15)),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'On Time':
        return const Color(0xFF008751);
      case 'Delayed':
        return Colors.orange;
      case 'Boarding':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
