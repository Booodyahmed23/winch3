import 'package:carwinch/winch_home/service/winch_page/pick_location_page.dart';
import 'package:carwinch/winch_home/service/winch_page/request_winch_page.dart';
import 'package:flutter/material.dart';
import 'package:carwinch/color_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WinchService extends StatelessWidget {
  const WinchService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorController.primaryDarkMode,
        title: const Text(
          'Winch Service',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),


            Image.asset(
              'assets/images/winch2.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 20),


            Text(
              'Need help towing your vehicle? Our winch service is available 24/7 to assist you in any situation. Get professional assistance now!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ColorController.primaryDarkMode,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorController.primaryDarkMode,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickLocationPage(onLocationPicked: (LatLng location) {  },),
                  ),
                );
              },
              child: const Text(
                'Request Winch Service',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
