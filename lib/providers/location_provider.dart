import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/google_maps_service.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _currentLatLng;
  String _currentAddress = "";
  bool _isLoading = false;

  LatLng? get currentLatLng => _currentLatLng;
  String get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;

  // ====== GET CURRENT LOCATION & ADDRESS ======
  Future<void> fetchCurrentLocation() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await GoogleMapsService.getCurrentLocationWithAddress();

      _currentLatLng = data['latLng'];
      _currentAddress = data['address'];

    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ====== GET ADDRESS FROM LATLNG ======
  Future<void> getAddressFromLatLng(LatLng latLng) async {
    try {
      _isLoading = true;
      notifyListeners();

      final address = await GoogleMapsService.getAddressFromLatLng(latLng);

      _currentLatLng = latLng;
      _currentAddress = address;

    } catch (e) {
      debugPrint("Error fetching address: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ====== SET ADDRESS MANUALLY ======
  void setAddress(String newAddress) {
    _currentAddress = newAddress;
    notifyListeners();
  }

  // ====== SET LAT LNG MANUALLY ======
  void setLatLng(LatLng latLng) {
    _currentLatLng = latLng;
    notifyListeners();
  }
}
