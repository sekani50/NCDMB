import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/artisan.dart';

class TrackingScreen extends StatefulWidget {
  final Artisan artisan;
  const TrackingScreen({super.key, required this.artisan});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Simulated route from Victoria Island to Lekki Phase 1
  final List<LatLng> _routePoints = [
    const LatLng(6.428354, 3.430959),
    const LatLng(6.428359, 3.431213),
    const LatLng(6.428372, 3.431831),
    const LatLng(6.42885, 3.431891),
    const LatLng(6.430013, 3.43204),
    const LatLng(6.430229, 3.432067),
    const LatLng(6.430263, 3.432096),
    const LatLng(6.430293, 3.432149),
    const LatLng(6.430312, 3.432235),
    const LatLng(6.430329, 3.432855),
    const LatLng(6.430331, 3.432904),
    const LatLng(6.430372, 3.434394),
    const LatLng(6.430976, 3.434378),
    const LatLng(6.430978, 3.434423),
    const LatLng(6.430984, 3.434878),
    const LatLng(6.430989, 3.435352),
    const LatLng(6.431007, 3.436302),
    const LatLng(6.431006, 3.436586),
    const LatLng(6.431004, 3.436679),
    const LatLng(6.430993, 3.436951),
    const LatLng(6.430958, 3.437283),
    const LatLng(6.430906, 3.437554),
    const LatLng(6.430842, 3.437812),
    const LatLng(6.430779, 3.438066),
    const LatLng(6.430698, 3.43835),
    const LatLng(6.430643, 3.438491),
    const LatLng(6.430478, 3.43898),
    const LatLng(6.430403, 3.439226),
    const LatLng(6.430366, 3.439399),
    const LatLng(6.430344, 3.439578),
    const LatLng(6.430342, 3.439786),
    const LatLng(6.430363, 3.44031),
    const LatLng(6.430375, 3.440918),
    const LatLng(6.430377, 3.441018),
    const LatLng(6.430383, 3.441093),
    const LatLng(6.430461, 3.44109),
    const LatLng(6.431103, 3.441059),
    const LatLng(6.431187, 3.441054),
    const LatLng(6.431244, 3.441054),
    const LatLng(6.431622, 3.441036),
    const LatLng(6.431761, 3.441032),
    const LatLng(6.431843, 3.441026),
    const LatLng(6.432562, 3.441001),
    const LatLng(6.433448, 3.44098),
    const LatLng(6.433787, 3.440973),
    const LatLng(6.433899, 3.440925),
    const LatLng(6.434012, 3.440838),
    const LatLng(6.43416, 3.440701),
    const LatLng(6.434265, 3.440567),
    const LatLng(6.434355, 3.440373),
    const LatLng(6.434831, 3.440521),
    const LatLng(6.435966, 3.440491),
    const LatLng(6.436374, 3.440498),
    const LatLng(6.436489, 3.440517),
    const LatLng(6.436536, 3.440547),
    const LatLng(6.436564, 3.44057),
    const LatLng(6.43658, 3.440603),
    const LatLng(6.436598, 3.440647),
    const LatLng(6.436606, 3.440691),
    const LatLng(6.436612, 3.440728),
    const LatLng(6.436615, 3.44082),
    const LatLng(6.436417, 3.441143),
    const LatLng(6.435826, 3.442186),
    const LatLng(6.435636, 3.442564),
    const LatLng(6.435611, 3.442622),
    const LatLng(6.435567, 3.442726),
    const LatLng(6.435457, 3.442998),
    const LatLng(6.435383, 3.443209),
    const LatLng(6.435336, 3.443393),
    const LatLng(6.43529, 3.443618),
    const LatLng(6.435262, 3.443875),
    const LatLng(6.435257, 3.443978),
    const LatLng(6.435228, 3.444297),
    const LatLng(6.435228, 3.444477),
    const LatLng(6.435239, 3.444679),
    const LatLng(6.435254, 3.444887),
    const LatLng(6.435276, 3.445086),
    const LatLng(6.435336, 3.445468),
    const LatLng(6.435451, 3.446096),
    const LatLng(6.43555, 3.44659),
    const LatLng(6.43572, 3.447255),
    const LatLng(6.435836, 3.447703),
    const LatLng(6.436007, 3.448295),
    const LatLng(6.436169, 3.448804),
    const LatLng(6.436318, 3.449191),
    const LatLng(6.43659, 3.449863),
    const LatLng(6.436731, 3.450159),
    const LatLng(6.43761, 3.451799),
    const LatLng(6.437698, 3.451998),
    const LatLng(6.437758, 3.452182),
    const LatLng(6.437786, 3.452348),
    const LatLng(6.437802, 3.45253),
    const LatLng(6.437795, 3.452726),
    const LatLng(6.437768, 3.452927),
    const LatLng(6.437716, 3.453118),
    const LatLng(6.43763, 3.45334),
    const LatLng(6.437534, 3.453513),
    const LatLng(6.437408, 3.45368),
    const LatLng(6.43729, 3.453811),
    const LatLng(6.436753, 3.454339),
    const LatLng(6.436661, 3.454422),
    const LatLng(6.436623, 3.454461),
    const LatLng(6.436565, 3.454596),
    const LatLng(6.436412, 3.454761),
    const LatLng(6.436286, 3.45489),
    const LatLng(6.436151, 3.455044),
    const LatLng(6.436133, 3.455126),
    const LatLng(6.436099, 3.455261),
    const LatLng(6.436091, 3.455356),
    const LatLng(6.436234, 3.455489),
    const LatLng(6.436325, 3.455574),
    const LatLng(6.43641, 3.45565),
    const LatLng(6.436498, 3.455741),
    const LatLng(6.436623, 3.455862),
    const LatLng(6.436851, 3.456061),
    const LatLng(6.436971, 3.456169),
    const LatLng(6.437083, 3.45626),
    const LatLng(6.437202, 3.456373),
    const LatLng(6.437301, 3.456414),
    const LatLng(6.437409, 3.456455),
    const LatLng(6.437556, 3.456518),
    const LatLng(6.437738, 3.456557),
    const LatLng(6.437902, 3.45658),
    const LatLng(6.438083, 3.456597),
    const LatLng(6.438109, 3.456597),
    const LatLng(6.438256, 3.456594),
    const LatLng(6.438376, 3.456583),
    const LatLng(6.43853, 3.456554),
    const LatLng(6.438669, 3.456511),
    const LatLng(6.438792, 3.456465),
    const LatLng(6.438957, 3.456388),
    const LatLng(6.43909, 3.456314),
    const LatLng(6.439182, 3.456251),
    const LatLng(6.439305, 3.456154),
    const LatLng(6.439386, 3.456073),
    const LatLng(6.439419, 3.45604),
    const LatLng(6.439511, 3.455932),
    const LatLng(6.439621, 3.455779),
    const LatLng(6.439843, 3.455461),
    const LatLng(6.439986, 3.455264),
    const LatLng(6.440047, 3.455181),
    const LatLng(6.440251, 3.454903),
    const LatLng(6.440334, 3.454795),
    const LatLng(6.440436, 3.454672),
    const LatLng(6.440523, 3.454589),
    const LatLng(6.440625, 3.454501),
    const LatLng(6.440761, 3.454412),
    const LatLng(6.440887, 3.454353),
    const LatLng(6.44103, 3.454304),
    const LatLng(6.441152, 3.454277),
    const LatLng(6.441261, 3.454262),
    const LatLng(6.441441, 3.454258),
    const LatLng(6.441621, 3.45427),
    const LatLng(6.442579, 3.45437),
    const LatLng(6.442938, 3.454404),
    const LatLng(6.443102, 3.454428),
    const LatLng(6.443233, 3.454459),
    const LatLng(6.443381, 3.454511),
    const LatLng(6.443506, 3.454573),
    const LatLng(6.443634, 3.454653),
    const LatLng(6.443759, 3.454752),
    const LatLng(6.44386, 3.454859),
    const LatLng(6.44394, 3.454964),
    const LatLng(6.444015, 3.455082),
    const LatLng(6.444096, 3.45523),
    const LatLng(6.445859, 3.458755),
    const LatLng(6.446183, 3.459397),
    const LatLng(6.446272, 3.459623),
    const LatLng(6.446355, 3.459839),
    const LatLng(6.446374, 3.459902),
    const LatLng(6.446482, 3.460249),
    const LatLng(6.446605, 3.460693),
    const LatLng(6.446628, 3.460805),
    const LatLng(6.446642, 3.460915),
    const LatLng(6.446638, 3.460967),
    const LatLng(6.44662, 3.461047),
    const LatLng(6.446589, 3.461108),
    const LatLng(6.446576, 3.461176),
    const LatLng(6.446584, 3.461245),
    const LatLng(6.446611, 3.461308),
    const LatLng(6.446656, 3.46136),
    const LatLng(6.446724, 3.46148),
    const LatLng(6.44675, 3.46155),
    const LatLng(6.446762, 3.4616),
    const LatLng(6.446775, 3.461685),
    const LatLng(6.446785, 3.461798),
    const LatLng(6.446855, 3.462358),
    const LatLng(6.446938, 3.462961),
    const LatLng(6.447125, 3.464125),
    const LatLng(6.447126, 3.464325),
    const LatLng(6.447384, 3.46616),
    const LatLng(6.447418, 3.466421),
    const LatLng(6.44759, 3.467603),
    const LatLng(6.447616, 3.467777),
    const LatLng(6.44772, 3.468465),
    const LatLng(6.447751, 3.468744),
    const LatLng(6.447775, 3.469057),
    const LatLng(6.447791, 3.469338),
    const LatLng(6.447808, 3.469667),
    const LatLng(6.44781, 3.469855),
    const LatLng(6.447817, 3.47011),
    const LatLng(6.447818, 3.470208),
    const LatLng(6.447921, 3.470208),
    const LatLng(6.448202, 3.470206),
    const LatLng(6.448786, 3.470202),
    const LatLng(6.450405, 3.470205),
    const LatLng(6.450406, 3.470112),
    const LatLng(6.449788, 3.470111),
    const LatLng(6.449298, 3.47011),
    const LatLng(6.449298, 3.470034),
    const LatLng(6.4493, 3.469986),
    const LatLng(6.449419, 3.469986),
    const LatLng(6.449421, 3.469694),
    const LatLng(6.449463, 3.469672),
    const LatLng(6.449464, 3.46922),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {}); // Rebuild to update marker position
      });

    // Start the animation and loop it for simulation purposes
    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Calculate current position based on animation value (0.0 to 1.0)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Interactive Map
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(6.4390, 3.4494), // Center of the route
                initialZoom: 14.5,
                interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.ncdmb.artisan',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      color: const Color(0xFF008751).withOpacity(0.8),
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    // User Destination Marker
                    Marker(
                      point: _routePoints.last,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                    // Moving Artisan Marker
                    Marker(
                      point: _currentPosition,
                      width: 50,
                      height: 50,
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
                        child: const Icon(Icons.handyman_rounded, color: Color(0xFF008751), size: 28),
                      ),
                    ),
                  ],
                ),
              ],
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
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 30, backgroundImage: AssetImage(widget.artisan.imagePath)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.artisan.name, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  _buildLocationInfo(Icons.person_pin_circle, 'Artisan Location', 'Moving...'),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 12)),
              Text(subtitle, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
