import 'package:carwinch/winch_home/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carwinch/color_controller.dart';

import '../dd.dart';

class MapScreen extends StatefulWidget {
  final GoogleMapController? mapController;
  final Set<Marker>? markers;
  final LatLng? fromLatLng;
  final LatLng? toLatLng;
  final String? price;
  MapScreen({
    Key? key,
    this.fromLatLng,
    this.mapController,
    this.markers,
    this.toLatLng, this.price,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14.4746,
  );

  GoogleMapController? _mapController;

  get price => widget.price??"0.0";

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _navigateToRoutePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoutePage(),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorController.primaryDarkMode,
        title: Text(
          'Search Locations',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Stack(
        children: [

          Positioned.fill(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: _kGooglePlex,
              markers: widget.markers ?? {},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),


          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    "Selected Route Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorController.primaryDarkMode,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "From: ${widget.fromLatLng?.latitude}, ${widget.fromLatLng?.longitude}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    "To: ${widget.toLatLng?.latitude}, ${widget.toLatLng?.longitude}",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Text(
                    'Estimated Price: \$$price',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeLayout(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorController.primaryDarkMode,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorController.primaryLiteMode,
                        ),
                      ),
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
}
