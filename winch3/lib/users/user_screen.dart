import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // AppBar height
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF474737), Color(0xFF33A333)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set background to transparent
            elevation: 0, // Remove shadow to let gradient show through
            iconTheme: const IconThemeData(
              color: Colors.white, // Set back arrow color to white
            ),
            title: const Text(
              'User Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF474737), Color(0xFF33A333)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Section
              Container(
                width: width * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,

                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'abdelrahaman', // Replace with dynamic username
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'User', // Replace with dynamic user role if needed
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Menu Section
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.green),
                      title: const Text('Settings'),
                      onTap: () {
                        // Navigate to settings screen
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.green),
                      title: const Text('Notifications'),
                      onTap: () {
                        // Navigate to notifications screen
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help, color: Colors.green),
                      title: const Text('Help & Support'),
                      onTap: () {
                        // Navigate to help screen
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app, color: Colors.green),
                      title: const Text('Logout'),
                      onTap: () {
                        // Implement logout logic
                        Navigator.pop(context); // Go back to login screen (or home screen)
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement additional action logic
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
