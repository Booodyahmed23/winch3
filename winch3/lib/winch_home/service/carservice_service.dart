import 'package:carwinch/winch_home/service/winch_page/winch_service.dart';
import 'package:flutter/material.dart';
import 'package:carwinch/color_controller.dart';
import '../home_layout.dart';


class CarServiceService extends StatelessWidget {
  const CarServiceService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorController.primaryDarkMode,
        title: const Text(
          'Our Services',
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
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.1, // Adjust item size
          ),
          children: [
            _buildServiceCard(
              context,
              title: "Winch Service",
              imagePath: "assets/images/towing.png",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WinchService()),
                );
              },
            ),
            _buildServiceCard(
              context,
              title: "Car Repair",
              imagePath: "assets/images/car_repair.png",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeLayout()),
                );
              },
            ),
            _buildServiceCard(
              context,
              title: "Battery Jumpstart",
              imagePath: "assets/images/battery.png",
              onTap: () {
                // Add navigation logic
              },
            ),
            _buildServiceCard(
              context,
              title: "Fuel Delivery",
              imagePath: "assets/images/fuel.png",
              onTap: () {
                // Add navigation logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context,
      {required String title, required String imagePath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorController.primaryDarkMode,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
