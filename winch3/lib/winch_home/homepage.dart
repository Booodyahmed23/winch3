import 'package:flutter/material.dart';
import '../auth/login_screen.dart';
import '../color_controller.dart';
import '../select/select_address_screen.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  Widget buildStoryItem(String imagePath) {
    return Container(
      width: 370.0,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final winchImages = [
      'assets/images/istockphoto-1290263633-612x612.png',
      'assets/images/winch2.webp',
      'assets/images/istockphoto-1360003193-612x612.jpg',
    ];

    final serviceShopImages = [
      'assets/images/carservice.jpg',
      'assets/images/car service2.png',
      'assets/images/carservice3.jpg',
      'assets/images/carservice3.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: ColorController.primaryDarkMode,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Winch',
            style: TextStyle(
              color: ColorController.primaryLiteMode,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: ColorController.primaryLiteMode,
            ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
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
                      backgroundColor: Colors.white.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Where To?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Winch',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, left: 20),
                  child: SizedBox(
                    height: 150.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildStoryItem(winchImages[index]),
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                      itemCount: winchImages.length,
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Car Service Shop',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50, left: 20),
                  child: SizedBox(
                    height: 150.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildStoryItem(serviceShopImages[index]),
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                      itemCount: serviceShopImages.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
