import 'package:carwinch/color_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _carplateController = TextEditingController();

  String? _userType = 'User';

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final userData = {
          'firstName': _firstNameController.text.trim(),
          'secondName': _secondNameController.text.trim(),
          'email': _emailController.text.trim(),
          'mobileNumber': _mobileNumberController.text.trim(),
          'userType': _userType,
          if (_userType == 'user') 'brand': _brandController.text.trim(),
          if (_userType == 'user') 'model': _modelController.text.trim(),
          if (_userType == 'user') 'brand': _carplateController.text.trim(),
          if (_userType == 'Winch') 'brand': _brandController.text.trim(),
          if (_userType == 'Winch') 'model': _modelController.text.trim(),
          if (_userType == 'Winch') 'brand': _carplateController.text.trim(),
          if (_userType == 'Car Service')
            'location': _locationController.text.trim(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          ...(userData),
          'brand': _brandController.text.trim(),
          'model': _modelController.text.trim(),
          'carPlate': _carplateController.text.trim(),
        });
        if (_userType == 'Winch') {
          await FirebaseFirestore.instance
              .collection('winch')
              .doc(credential.user!.uid)
              .set({
            ...(userData),
            'brand': _brandController.text.trim(),
            'model': _modelController.text.trim(),
            'carPlate': _carplateController.text.trim(),
          });
        } else if (_userType == 'Car Service') {
          await FirebaseFirestore.instance
              .collection('car_service')
              .doc(credential.user!.uid)
              .set({
            ...userData,
            'location': _locationController.text.trim(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sign-Up Successful!'),
              backgroundColor: Colors.green),
        );

        Navigator.of(context).pushReplacementNamed('/homescreen');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else {
          errorMessage = 'An error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred: $e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: ColorController.primaryLiteMode,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: ColorController.primaryDarkMode,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Create a new account to get started!',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorController.primaryDarkMode,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: _firstNameController,
                      hint: 'First Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _secondNameController,
                      hint: 'Second Name',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emailController,
                      hint: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _retypePasswordController,
                      hint: 'Re-type Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _mobileNumberController,
                      hint: 'Mobile Number',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _userType,
                      decoration: _dropdownDecoration(),
                      items: const [
                        DropdownMenuItem(value: 'User', child: Text('User')),
                        DropdownMenuItem(value: 'Winch', child: Text('Winch')),
                        DropdownMenuItem(
                            value: 'Car Service', child: Text('Car Service')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _userType = value;
                        });
                      },
                    ),
                    if (_userType == 'User') ...[
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _brandController,
                        hint: 'Brand',
                        icon: Icons.car_repair,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _modelController,
                        hint: 'Model',
                        icon: Icons.directions_car,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _carplateController,
                        hint: 'Car Plate',
                        icon: Icons.numbers,
                      ),
                    ],
                    if (_userType == 'Winch') ...[
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _brandController,
                        hint: 'Brand',
                        icon: Icons.car_repair,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _modelController,
                        hint: 'Model',
                        icon: Icons.fire_truck,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: _carplateController,
                        hint: 'Car Plate',
                        icon: Icons.numbers,
                      ),
                    ],
                    if (_userType == 'Car Service') ...[
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _locationController,
                        hint: 'Service Location',
                        icon: Icons.location_on,
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorController.primaryDarkMode,
                        foregroundColor: ColorController.primaryLiteMode,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 80),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Log In',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
        hintStyle: TextStyle(color: ColorController.primaryDarkMode),
        prefixIcon: Icon(icon, color: ColorController.primaryDarkMode),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: ColorController.primaryDarkMode,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: ColorController.primaryLiteMode,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
          color: ColorController.orange,
          width: 2,
        ),
      ),
    );
  }
}
