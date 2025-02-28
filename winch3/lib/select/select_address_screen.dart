import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter_api/google_places_flutter_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../color_controller.dart';
import '../maps/map_screen.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _RoutePageState();
}

class _RoutePageState extends State<SelectAddressScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  LatLng? fromLatLng;
  LatLng? toLatLng;
  String price = "0.00"; // Declare price variable

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  Future<void> _calculatePrice() async {
    if (fromLatLng != null && toLatLng != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        fromLatLng!.latitude, fromLatLng!.longitude,
        toLatLng!.latitude, toLatLng!.longitude,
      );

      double distanceInKm = distanceInMeters / 1000;
      double pricePerKm = 2.5; //  $2.5 per km
      double totalPrice = distanceInKm * pricePerKm;

      setState(() {
        price = totalPrice.toStringAsFixed(2);
      });
    }
  }

  Future<void> _searchLocation({required bool isFromLocation}) async {
    try {
      var places = await PlacesAutocomplete.show(
        context: context,
        apiKey: "AIzaSyB74uwwESOOrHljNdslaA1cb8iseyiLYPM",
        mode: Mode.fullscreen,
        language: "en",
      );

      if (places != null) {
        List<geocoding.Location> locations =
        await geocoding.locationFromAddress(places.description ?? "");
        if (locations.isNotEmpty) {
          geocoding.Location location = locations.first;
          LatLng latLng = LatLng(location.latitude, location.longitude);

          setState(() {
            if (isFromLocation) {
              _setFromLocation(latLng, places.description);
            } else {
              _setToLocation(latLng, places.description);
              _saveToFirebase();
              _navigateToMapScreen();
            }
          });

          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(latLng, 14),
          );
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _setFromLocation(LatLng latLng, String? description) {
    fromLatLng = latLng;
    fromController.text = description ?? "";
    _addMarker(latLng, "From: $description", "From");
  }

  void _setToLocation(LatLng latLng, String? description) {
    toLatLng = latLng;
    toController.text = description ?? "";
    _addMarker(latLng, "To: $description", "To");

    _calculatePrice();
  }

  void _addMarker(LatLng position, String title, String markerId) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: title),
      ),
    );
  }

  Future<void> _saveToFirebase() async {
    if (fromLatLng != null && toLatLng != null) {
      try {
        await firestore.collection('routes').add({
          'from': {
            'latitude': fromLatLng!.latitude,
            'longitude': fromLatLng!.longitude,
            'description': fromController.text,
          },
          'to': {
            'latitude': toLatLng!.latitude,
            'longitude': toLatLng!.longitude,
            'description': toController.text,
          },
          'price': price,
          'timestamp': FieldValue.serverTimestamp(),
        });
        debugPrint("Locations saved to Firebase successfully!");
      } catch (e) {
        debugPrint("Failed to save locations: $e");
      }
    } else {
      debugPrint("Both locations must be selected before saving.");
    }
  }

  void _navigateToMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          fromLatLng: fromLatLng,
          toLatLng: toLatLng,
          mapController: mapController,
          markers: _markers,
          price:price ,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorController.primaryDarkMode,
        title: Text(
          'Route Details',
          style: TextStyle(
            color: ColorController.primaryLiteMode,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorController.primaryLiteMode),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLocationField(
              controller: fromController,
              label: 'Your Location',
              onTap: () => _searchLocation(isFromLocation: true),
            ),
            const SizedBox(height: 10),
            _buildLocationField(
              controller: toController,
              label: 'Where To',
              onTap: () => _searchLocation(isFromLocation: false),
            ),
            const SizedBox(height: 20),
            Text(
              'Estimated Price: \$$price',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required String label,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14, color: ColorController.primaryDarkMode),
        prefixIcon: const Icon(Icons.location_on, color: ColorController.primaryDarkMode),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorController.primaryDarkMode, width: 1.5),
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
      onTap: onTap,
    );
  }
}
