import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../color_controller.dart';
import 'home_layout.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: ColorController.primaryDarkMode,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'History',
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
        color: ColorController.primaryLiteMode,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('routes').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading data"));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No history available"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var from = doc['from']['description'];
                var to = doc['to']['description'];
                var timestamp = (doc['timestamp'] as Timestamp).toDate();

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.history, color: Colors.blue),
                    title: Text("From: $from"),
                    subtitle: Text("To: $to\n${timestamp.toLocal()}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await doc.reference.delete();
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
