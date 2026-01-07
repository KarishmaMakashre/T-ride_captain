// Updated GoogleMapsService: lib/services/google_maps_service.dart
// Made googleApiKey public (removed underscore)
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleMapsService {
  static const String googleApiKey = 'AIzaSyBWRCvfFaZH_SOsaxyS5dtS--zsl9aMDLU';
  static const String _placesApiUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  // Get current location and address (reuse from HomeScreen logic)
  static Future<Map<String, dynamic>> getCurrentLocationWithAddress() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks.isNotEmpty ? placemarks[0] : Placemark();
    
    String address = '${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}';
    LatLng latLng = LatLng(position.latitude, position.longitude);

    return {
      'position': position,
      'latLng': latLng,
      'address': address,
    };
  }

  static Future<String> getAddressFromLatLng(LatLng latLng) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  Placemark place = placemarks.isNotEmpty ? placemarks[0] : Placemark();
  return '${place.name ?? ''}, ${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}';
}

  // Get nearby places suggestions based on query (using Places API)
  static Future<List<dynamic>> getNearbyPlaceSuggestions(String input, LatLng currentLatLng) async {
    // Note: google_places_flutter handles autocomplete internally, but for custom, use this
    // For now, returning empty list as package handles it. If needed, integrate.
    return [];
  }

  // Get LatLng from place ID (for selected suggestion)
  static Future<LatLng> getLatLngFromPlaceId(String placeId) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=${googleApiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    }
    throw Exception('Failed to get location for place');
  }

  // Calculate route (simple polyline example; for full directions, use Directions API)
  static Future<List<LatLng>> getSimpleRoute(LatLng origin, LatLng destination) async {
    // For demo, return a straight line between points. In production, use Directions API.
    return [origin, destination];
  }
}