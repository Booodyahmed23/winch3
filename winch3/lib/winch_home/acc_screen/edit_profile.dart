import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../color_controller.dart';
import 'account_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _carPlateController = TextEditingController();
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    data.addAll(querySnapshot.docs);

    for (int i = 0; i < data.length; i++) {
      if (FirebaseAuth.instance.currentUser?.email == data[i]["email"]) {
        _firstNameController.text = data[i]["firstName"];
        _mobileNumberController.text = data[i]["mobileNumber"];
        _lastNameController.text = data[i]["secondName"];
        _brandController.text = data[i]["brand"];
        _modelController.text = data[i]["model"];
        _carPlateController.text = data[i]["carPlate"];
      }

      var document = data[i];

      print('Document $i: ${document['fieldName']}');
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: ColorController.primaryLiteMode,
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorController.primaryLiteMode,
              ),
              padding: const EdgeInsets.only(top: 40, bottom: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: ColorController.textColorLIte,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountScreen(
                            email: '',
                          ),
                        ),
                      );
                    },
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: ColorController.primaryDarkMode,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: ColorController.primaryDarkMode,
                              width: 3, // Border width
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://st3.depositphotos.com/1432405/12536/v/950/depositphotos_125360840-stock-illustration-car-towing-truck-icon-outline.jpg',
                            ),
                            radius: 60,
                          ),
                        )),
                        SizedBox(
                          height: 16,
                        ),
                        _buildTextField(
                          controller: _firstNameController,
                          hint: 'First Name',
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _lastNameController,
                          hint: 'Last Name',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _mobileNumberController,
                          hint: 'Mobile Number',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _brandController,
                          hint: 'Brand',
                          icon: Icons.car_repair,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _modelController,
                          hint: 'Model',
                          icon: Icons.directions_car,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _carPlateController,
                          hint: 'Car Plate',
                          icon: Icons.numbers,
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: ElevatedButton(
                            onPressed: _saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorController.primaryDarkMode,
                              foregroundColor: ColorController.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 80),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: ColorController.primaryLiteMode,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorController.primaryLiteMode,
        hintText: hint,
        hintStyle: const TextStyle(
          color: ColorController.orange,
        ),
        prefixIcon: Icon(icon, color: ColorController.primaryDarkMode),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: ColorController.primaryDarkMode,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: ColorController.primaryDarkMode,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: ColorController.textColorLIte,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
