// New file: lib/screens/map_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';
import 'package:tryde_partner/services/google_maps_service.dart';

class MapSelectionScreen extends StatefulWidget {
  final String mode; // 'origin' or 'destination'
  final LatLng? currentLatLng;
  final Function(LatLng, String) onSelected;

  const MapSelectionScreen({
    super.key,
    required this.mode,
    this.currentLatLng,
    required this.onSelected,
  });

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;
  String _selectedAddress = '';
  Set<Marker> _markers = {};
  bool _isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() async {
    // Add current location marker if selecting origin
    if (widget.mode == 'origin' && widget.currentLatLng != null) {
      _markers.add(Marker(
        markerId: const MarkerId('current'),
        position: widget.currentLatLng!,
        infoWindow: const InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(widget.currentLatLng!, 15));
    }
  }

  void _onMapTap(LatLng latLng) async {
    setState(() {
      _selectedLatLng = latLng;
      _isLoadingAddress = true;
    });

    // Remove previous selected marker
    _markers.removeWhere((m) => m.markerId.value == 'selected');

    // Add new selected marker
    _markers.add(Marker(
      markerId: const MarkerId('selected'),
      position: latLng,
      infoWindow: InfoWindow(title: 'Selected Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));

    // Get address
    try {
      final address = await GoogleMapsService.getAddressFromLatLng(latLng);
      setState(() {
        _selectedAddress = address;
        _isLoadingAddress = false;
      });
    } catch (e) {
      setState(() {
        _selectedAddress = 'Unable to fetch address';
        _isLoadingAddress = false;
      });
    }
  }

  void _confirmSelection() {
    if (_selectedLatLng != null && _selectedAddress.isNotEmpty) {
      widget.onSelected(_selectedLatLng!, _selectedAddress);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.mode.toUpperCase()} Selection',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.currentLatLng ?? const LatLng(22.7196, 75.8577), // Fallback
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _initializeMap();
            },
            markers: _markers,
            onTap: _onMapTap,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Bottom sheet for selected info
          if (_selectedLatLng != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoadingAddress)
                      const CircularProgressIndicator()
                    else ...[
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(child: Text(_selectedAddress)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _confirmSelection,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Confirm Location',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}