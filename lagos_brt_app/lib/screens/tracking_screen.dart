import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/bus.dart';

class TrackingScreen extends StatefulWidget {
  final Bus bus;
  const TrackingScreen({super.key, required this.bus});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Real route: Anthony to Maryland (Ikorodu Road)
  final List<LatLng> _routePoints = [
    const LatLng(6.560802, 3.367296),
    const LatLng(6.560799, 3.367169),
    const LatLng(6.560786, 3.367004),
    const LatLng(6.562024, 3.366982),
    const LatLng(6.562592, 3.366961),
    const LatLng(6.562658, 3.36696),
    const LatLng(6.563171, 3.366946),
    const LatLng(6.563702, 3.366928),
    const LatLng(6.564, 3.366913),
    const LatLng(6.564283, 3.366907),
    const LatLng(6.564345, 3.366906),
    const LatLng(6.565024, 3.366892),
    const LatLng(6.565454, 3.366895),
    const LatLng(6.565888, 3.366891),
    const LatLng(6.566156, 3.366914),
    const LatLng(6.566274, 3.366918),
    const LatLng(6.566391, 3.366919),
    const LatLng(6.566435, 3.366921),
    const LatLng(6.56647, 3.366919),
    const LatLng(6.566686, 3.366931),
    const LatLng(6.566897, 3.366943),
    const LatLng(6.567057, 3.366952),
    const LatLng(6.567455, 3.366977),
    const LatLng(6.567664, 3.366995),
    const LatLng(6.567674, 3.366997),
    const LatLng(6.567892, 3.367016),
    const LatLng(6.568375, 3.367057),
    const LatLng(6.568479, 3.367073),
    const LatLng(6.568778, 3.367114),
    const LatLng(6.56901, 3.367151),
    const LatLng(6.569263, 3.367169),
    const LatLng(6.569718, 3.367285),
    const LatLng(6.570294, 3.367445),
    const LatLng(6.570809, 3.367598),
    const LatLng(6.571293, 3.367764),
    const LatLng(6.571433, 3.367823),
    const LatLng(6.571469, 3.367838),
    const LatLng(6.571545, 3.367871),
    const LatLng(6.57166, 3.367923),
    const LatLng(6.571658, 3.367873),
    const LatLng(6.571661, 3.367852),
    const LatLng(6.571665, 3.367824),
    const LatLng(6.571674, 3.367782),
    const LatLng(6.5717, 3.367731),
    const LatLng(6.571782, 3.367538),
    const LatLng(6.571825, 3.367409),
    const LatLng(6.571829, 3.367395),
    const LatLng(6.571884, 3.367247),
    const LatLng(6.571977, 3.366969),
    const LatLng(6.571985, 3.366945),
    const LatLng(6.572104, 3.366609),
    const LatLng(6.572897, 3.366993),
    const LatLng(6.573356, 3.367214),
    const LatLng(6.573704, 3.367384),
    const LatLng(6.574037, 3.367568),
    const LatLng(6.574556, 3.367875),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {}); // Update UI when arrived
        }
      });

    _animationController.forward();
  }

  bool get _hasArrived => _animationController.isCompleted;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  LatLng get _currentPosition {
    if (_routePoints.isEmpty) return const LatLng(0, 0);
    if (_animation.value >= 1.0) return _routePoints.last;
    if (_animation.value <= 0.0) return _routePoints.first;

    final totalSegments = _routePoints.length - 1;
    final scaledValue = _animation.value * totalSegments;
    final currentIndex = scaledValue.floor();
    final fraction = scaledValue - currentIndex;

    final startPoint = _routePoints[currentIndex];
    final endPoint = _routePoints[currentIndex + 1];

    final lat = startPoint.latitude + (endPoint.latitude - startPoint.latitude) * fraction;
    final lng = startPoint.longitude + (endPoint.longitude - startPoint.longitude) * fraction;

    return LatLng(lat, lng);
  }

  // Define traffic segments
  List<Polyline> _buildTrafficPolylines() {
    if (_routePoints.length < 10) return [];
    
    // Divide the route into three segments:
    // 1. Clear (Green)
    // 2. Heavy Traffic / Accident (Red)
    // 3. Clear (Green)
    int firstThird = _routePoints.length ~/ 3;
    int secondThird = firstThird * 2;
    
    return [
      Polyline(
        points: _routePoints.sublist(0, firstThird + 1),
        color: Colors.green.withOpacity(0.8),
        strokeWidth: 6.0,
      ),
      Polyline(
        points: _routePoints.sublist(firstThird, secondThird + 1),
        color: Colors.red.withOpacity(0.8),
        strokeWidth: 6.0,
      ),
      Polyline(
        points: _routePoints.sublist(secondThird, _routePoints.length),
        color: Colors.green.withOpacity(0.8),
        strokeWidth: 6.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(6.5670, 3.3672), // Midpoint of Anthony-Maryland
                initialZoom: 15.0,
                interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.ncdmb.brt',
                ),
                PolylineLayer(
                  polylines: _buildTrafficPolylines(),
                ),
                MarkerLayer(
                  markers: [
                    // Accident Marker in the red zone
                    Marker(
                      point: _routePoints[_routePoints.length ~/ 2],
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
                    ),
                    // User Destination Marker (Maryland)
                    Marker(
                      point: _routePoints.last,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
                    ),
                    // Moving BRT Marker
                    Marker(
                      point: _currentPosition,
                      width: 60,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.directions_bus, color: Color(0xFF008751), size: 30),
                      ),
                    ),
                  ],
                ),
              ],
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
                GestureDetector(
                  onTap: () {
                    if (_hasArrived) {
                      _animationController.reset();
                      _animationController.forward();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _hasArrived ? Icons.refresh : Icons.circle,
                          color: _hasArrived ? Colors.blue : Colors.green,
                          size: _hasArrived ? 16 : 10,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _hasArrived ? 'Re-run' : 'Live Tracking',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            color: _hasArrived ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 44),
              ],
            ),
          ),

          // Simulation of Road Activities (Alerts)
          Positioned(
            top: 140,
            left: 20,
            child: _buildRoadActivityAlert(
              'Accident at Obanikoro',
              'Expect slight delays on Route ${widget.bus.id}',
              Colors.red,
            ),
          ),

          Positioned(
            top: 220,
            left: 20,
            child: _buildRoadActivityAlert(
              'Heavy Traffic',
              'Red zone indicates severe congestion',
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
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
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
                          color: const Color(0xFF008751).withOpacity(0.1),
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
                              _hasArrived ? 'Arrived!' : 'Arriving in 12 mins',
                              style: GoogleFonts.outfit(
                                color: _hasArrived ? Colors.blue : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
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
                  _buildLocationRow(Icons.location_on, 'BRT Current Location', _hasArrived ? 'At Maryland Interchange' : 'Approaching Maryland'),
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
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
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
