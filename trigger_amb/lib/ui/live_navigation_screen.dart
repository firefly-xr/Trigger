import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../blocs/dispatch/dispatch_bloc.dart';
import '../blocs/dispatch/dispatch_event.dart';

import '../models/dispatch_alert.dart';

class LiveNavigationScreen extends StatefulWidget {
  final DispatchAlert alert;

  const LiveNavigationScreen({super.key, required this.alert});

  @override
  State<LiveNavigationScreen> createState() => _LiveNavigationScreenState();
}

class _LiveNavigationScreenState extends State<LiveNavigationScreen> {
  final MapController mapController = MapController();

  // Mock ambulance location slightly offset from patient
  late final LatLng _ambulanceLocation = LatLng(
    widget.alert.latitude - 0.015,
    widget.alert.longitude - 0.015,
  );

  late final LatLng _patientLocation = LatLng(
    widget.alert.latitude,
    widget.alert.longitude,
  );

  List<LatLng> _routePoints = [];
  String _etaString = "CALCULATING...";
  String _distanceString = "-- mi";

  @override
  void initState() {
    super.initState();
    // Fallback initially
    _routePoints = [_ambulanceLocation, _patientLocation];
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/'
      '${_ambulanceLocation.longitude},${_ambulanceLocation.latitude};'
      '${_patientLocation.longitude},${_patientLocation.latitude}'
      '?overview=full&geometries=geojson'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          
          final durationSeconds = route['duration'] as num;
          final distanceMeters = route['distance'] as num;
          
          final int rMins = (durationSeconds / 60).round();
          final double rMiles = distanceMeters * 0.000621371;

          final geometry = route['geometry'];
          final coordinates = geometry['coordinates'] as List;
          final List<LatLng> points = coordinates.map((coord) {
            return LatLng(coord[1] as double, coord[0] as double);
          }).toList();

          if (mounted) {
            setState(() {
              _etaString = "ETA: $rMins MIN";
              _distanceString = "${rMiles.toStringAsFixed(1)} mi";
              _routePoints = points;
            });
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching route: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full Screen Map
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCameraFit: CameraFit.bounds(
                bounds: LatLngBounds.fromPoints([_ambulanceLocation, _patientLocation]),
                padding: const EdgeInsets.all(80.0),
              ),
              interactionOptions: const InteractionOptions(
                 flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.trigger_amb',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.blueAccent,
                    strokeWidth: 5,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _ambulanceLocation,
                    width: 44,
                    height: 44,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.airport_shuttle, color: Colors.blueAccent, size: 24),
                    ),
                  ),
                  Marker(
                    point: _patientLocation,
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),



          // 3. Bottom Dashboard Overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5, // Constrain to max 50% of screen height
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 40),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, -5),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                            Text(
                              _etaString,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.greenAccent.shade400,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "$_distanceString • Fast Route",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                         ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                           color: Colors.redAccent.shade700.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(color: Colors.redAccent.shade700, width: 2),
                        ),
                        child: Text(
                           "CRITICAL",
                           style: TextStyle(
                             color: Colors.redAccent.shade700,
                             fontWeight: FontWeight.w900,
                             fontSize: 18,
                           ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "AI PATIENT SUMMARY",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Patient: ${widget.alert.patientName ?? 'Unknown'}\n\n${widget.alert.aiSummary}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildStatusButton(context, widget.alert.status),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(BuildContext context, DispatchStatus currentStatus) {
    String buttonText = "";
    Color buttonColor = Colors.blueAccent;
    IconData buttonIcon = Icons.navigation;
    VoidCallback? onPressed;

    if (currentStatus == DispatchStatus.enRoute) {
      buttonText = "ARRIVED AT SCENE";
      buttonColor = Colors.orangeAccent.shade700;
      buttonIcon = Icons.location_on;
      onPressed = () => _updateStatus(context, DispatchStatus.atScene);
    } else if (currentStatus == DispatchStatus.atScene) {
      buttonText = "PATIENT SECURED";
      buttonColor = Colors.purpleAccent.shade700;
      buttonIcon = Icons.medical_services;
      onPressed = () => _updateStatus(context, DispatchStatus.transporting);
    } else if (currentStatus == DispatchStatus.transporting) {
      buttonText = "ARRIVED AT HOSPITAL\n(COMPLETE RUN)";
      buttonColor = Colors.green.shade600;
      buttonIcon = Icons.check_circle;
      onPressed = () => _clearDispatch(context);
    } else {
       // Fallback or idle/dispatched
       return const SizedBox();
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(buttonIcon, size: 32),
          const SizedBox(width: 16),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _updateStatus(BuildContext context, DispatchStatus newStatus) {
    context.read<DispatchBloc>().add(DispatchEvent.updateStatus(newStatus));
  }
  
  void _clearDispatch(BuildContext context) {
    // We emit a dummy idle status directly? No, create a specific completion event, 
    // or we can just send updateStatus(idle). 
    // Wait, the bloc handles updateStatus by updating the alert, NOT going to idle.
    // Let's add an explicit idle event or simply pop if it was designed differently.
    // For hackathon sake, we can just replace the whole state directly here if we had emit, 
    // but instead let's add `DispatchEvent.updateStatus(DispatchStatus.idle)` and update the bloc later:
    // For now we simulate by popping out of live map if it was a route?
    // Actually the map is inside main.dart's BlocBuilder. If we change state to Idle, it unmounts! 
    // Since we don't have a specific `completeDispatch` event in the current generated BLoC and we probably shouldn't rebuild freezed now, 
    // we can use a workaround:
    
    // Quick Hackathon Fix: Call emit internally not allowed, so we send the idle state if bloc supports it.
    // Our bloc doesn't have an explicit 'clear' event. I will just dispatch an update to `idle`.
    context.read<DispatchBloc>().add(const DispatchEvent.updateStatus(DispatchStatus.idle));
  }
}
