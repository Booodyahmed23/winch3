import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/login_screen.dart';
import '../../color_controller.dart';
import '../historypage.dart';
import '../home_layout.dart';
import 'edit_profile.dart';

class AccountScreen extends StatefulWidget {
  final String email;

  const AccountScreen({super.key, required this.email});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String firstName = "";

  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    for (var document in querySnapshot.docs) {
      if (FirebaseAuth.instance.currentUser?.email == document["email"]) {
        setState(() {
          firstName = document["firstName"];
        });
        break;
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget buildAccountOption(
    String title,
    IconData icon,
    VoidCallback onTap, {
    required Color iconColor,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ColorController.textColorLIte,
          fontSize: 20,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white70,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  void _showProfilePhoto(BuildContext context, String photoPath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(photoPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: ColorController.primaryDarkMode,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Account',
            style: TextStyle(
              color: ColorController.primaryLiteMode,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorController.primaryLiteMode),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
            );
          },
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: ColorController.primaryLiteMode,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showProfilePhoto(
                        context,
                        'assets/images/profile_photo.jpg',
                      );
                    },
                    child:  Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        border: Border.all(
                          color: ColorController.primaryDarkMode,
                          width: 3,  // Border width
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://st3.depositphotos.com/1432405/12536/v/950/depositphotos_125360840-stock-illustration-car-towing-truck-icon-outline.jpg',
                        ),
                        radius: 60,
                      ),
                    )

                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      Text(
                        firstName,
                        style: const TextStyle(
                          color: ColorController.primaryDarkMode,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? "",
                        style: const TextStyle(
                          color: ColorController.primaryDarkMode,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                buildAccountOption(
                  'Edit Profile',
                  Icons.person,
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  },
                  iconColor: ColorController.primaryDarkMode,
                  color: ColorController.primaryDarkMode,
                ),
                buildAccountOption(
                  'Change Password',
                  Icons.lock,
                  () {},
                  iconColor: ColorController.primaryDarkMode,
                  color: ColorController.primaryDarkMode,
                ),
                buildAccountOption(
                  'Order History',
                  Icons.history,
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Historypage(),
                      ),
                    );
                  },
                  iconColor: ColorController.primaryDarkMode,
                  color: ColorController.primaryDarkMode,
                ),
                buildAccountOption(
                  'Help & Support',
                  Icons.help,
                  () {},
                  iconColor: ColorController.primaryDarkMode,
                  color: ColorController.primaryDarkMode,
                ),
                buildAccountOption(
                  'Logout',
                  Icons.logout,
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  iconColor: ColorController.primaryDarkMode,
                  color: ColorController.primaryDarkMode,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
