import 'package:carwinch/maps/MapsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapsView(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        currentLocation: _currentLocation,
        markers: _markers,
      ),
      // body: ListView(
      //   children: [
      //     FirebaseAuth.instance.currentUser!.emailVerified
      //     ?Text('Welcome')
      //        :MaterialButton(
      //       textColor: Colors.white,
      //         color: Colors.black,
      //         onPressed:(){
      //         FirebaseAuth.instance.currentUser?.sendEmailVerification();
      //         },
      //  child: Text('Please Verify Your Email'),
      //     ),
      //   ],
      // ),
    );
  }
}
