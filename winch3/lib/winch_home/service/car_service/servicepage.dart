import 'package:carwinch/color_controller.dart';
import 'package:carwinch/winch_home/service/winch_page/winch_service.dart';
import 'package:flutter/material.dart';

import '../../home_layout.dart';
import '../carservice_service.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            color: ColorController.primaryDarkMode,
          ),

        ),
        title:  Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Service',
            style: TextStyle(
                color: ColorController.primaryLiteMode,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
          color: ColorController.primaryLiteMode,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
            );
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          color: ColorController.primaryLiteMode,
        ),

        child: Column(
          children: [
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WinchService(),
                      ),
                    );
                  },
                  child: Container(
                    width: 175,
                    height: 125,

                    decoration: BoxDecoration(
                      color: ColorController.primaryDarkMode,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ColorController.primaryDarkMode,
                        width: 2.0,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: const Text(
                            'Winch',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: ColorController.primaryLiteMode,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 70.0,
                            top: 4,
                          ),
                          child: SizedBox(height: 70,
                            width: 40,
                            child: Image.asset(
                              'assets/images/Towing.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CarServiceService(),
                      ),
                    );
                  },

                  child: Container(
                    width: 175,
                    height: 125,
                    decoration: BoxDecoration(
                      color: ColorController.primaryDarkMode,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Car Service',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 70.0,
                            top: 4,
                          ),
                          child: SizedBox(height: 70,
                            width: 40,
                            child: Image.asset(
                              'assets/images/Car Service.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
