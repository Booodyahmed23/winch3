// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   final Set<Marker> _markers = {};
//
//   // Initial camera position
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.7749, -122.4194), // San Francisco coordinates
//     zoom: 14.4746,
//   );
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Maps Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: _kGooglePlex,
//         markers: _markers,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add a marker at the current location
//           setState(() {
//             _markers.add(
//               Marker(
//                 markerId: MarkerId('current_location'),
//                 position: LatLng(37.7749, -122.4194), // San Francisco coordinates
//                 infoWindow: InfoWindow(title: 'San Francisco'),
//               ),
//             );
//           });
//         },
//         child: const Icon(Icons.add_location),
//       ),
//     );
//   }
// }
