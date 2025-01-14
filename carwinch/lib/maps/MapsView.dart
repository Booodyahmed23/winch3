import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../auth/login_screen.dart';
import '../select/select_address_screen.dart';
import 'package:carwinch/provider/provider.dart';  // Import your UiProvider class

class MapsView extends StatefulWidget {
  MapsView({
    Key? key,
    required this.onMapCreated,
    this.currentLocation,
    this.markers = const {},
  }) : super(key: key);

  final Set<Marker> markers;
  final LatLng? currentLocation;
  final Function(GoogleMapController) onMapCreated;

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  final LatLng _center = const LatLng(30.048086873879566, 31.21272666931322);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey, // Assign the key to Scaffold
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                print('Home tapped');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Maps'),
              onTap: () {
                Navigator.pop(context);
                print('Maps tapped');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                print('Settings tapped');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
                print('Logout tapped');
              },
            ),
            // Switch to toggle light/dark theme
            Consumer<UiProvider>(
              builder: (context, uiProvider, child) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: uiProvider.isDark,
                  onChanged: (value) {
                    uiProvider.changeTheme();  // Toggle theme
                  },
                  secondary: const Icon(Icons.dark_mode),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Google Map Widget
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: 13.0),
            myLocationEnabled: false,
            markers: widget.markers,
            onMapCreated: widget.onMapCreated,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
          ),
          // Floating Action Button for Drawer
          Positioned(
            top: 40,
            left: 20,
            child: Center(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.deepOrange,
                child: IconButton(
                  icon: const Icon(Icons.menu, size: 30, color: Colors.black),
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer(); // Open the drawer
                  },
                ),
              ),
            ),
          ),
          // Bottom Button
          Positioned(
            left: 15,
            right: 15,
            bottom: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectAddressScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Click Me',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
