import 'package:flutter/material.dart';

class SelectUserType extends StatefulWidget {
  final String email; // Add email parameter
  SelectUserType({super.key, required this.email});

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  // To keep track of the selected option
  String _selectedUserType = 'User'; // Default to 'User'

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF474737),
            Color(0xFF33A333)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),

                const Text(
                  'Winch',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                const SizedBox(height: 40),

                // Title for the options
                const Text(
                  'Select your User Type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 40),

                // Card with RadioListTiles for each option
                Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: const Text(
                          'User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: 'User',
                        groupValue: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      const Divider(),
                      RadioListTile<String>(
                        title: const Text(
                          'Winch',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: 'Winch',
                        groupValue: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      const Divider(),
                      RadioListTile<String>(
                        title: const Text(
                          'Car Service',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: 'Car Service',
                        groupValue: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Animated Button to go to the next screen based on the selected option
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _selectedUserType == 'User' ? width * 0.8 : width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedUserType == 'User') {
                        Navigator.pushNamed(context, '/user');
                      } else if (_selectedUserType == 'Winch') {
                        Navigator.pushNamed(context, '/winch');
                      } else {
                        Navigator.pushNamed(context, '/carService');
                      }
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
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
