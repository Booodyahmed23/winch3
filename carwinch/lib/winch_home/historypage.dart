import 'package:flutter/material.dart';

import '../color_controller.dart';
import 'home_layout.dart';

class Historypage extends StatelessWidget {
  const Historypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: ColorController.primaryLiteMode,
          ),
        ),
        title:
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            'History',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
      decoration: const BoxDecoration(
        color: ColorController.primaryLiteMode,
    ),
      ),
    );
  }
}
