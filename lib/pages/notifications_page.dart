import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bmi_details_page.dart';

class NotificationsPage extends StatelessWidget {
  final double bmi;
  final String bmiStatus;

  const NotificationsPage({
    Key? key,
    required this.bmi,
    required this.bmiStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFF30EC30),
      ),
      body: ListView(
        children: [
          _buildBMINotification(context),
          // Add more notifications here
        ],
      ),
    );
  }

  Widget _buildBMINotification(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFF30EC30),
          child: Icon(Icons.fitness_center, color: Colors.white),
        ),
        title: Text('BMI Update'),
        subtitle: Text('Your current BMI is ${bmi.toStringAsFixed(1)}'),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BMIDetailsPage(bmi: bmi, bmiStatus: bmiStatus),
              ),
            );
          },
          child: Text('View Details'),
        ),
      ),
    );
  }

  Future<void> showNotificationPopup(BuildContext context) async {
    if (await _checkNotificationsEnabled()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BMI Update'),
            content: Text(
              'Your current BMI is ${bmi.toStringAsFixed(1)}\nStatus: $bmiStatus',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              BMIDetailsPage(bmi: bmi, bmiStatus: bmiStatus),
                    ),
                  );
                },
                child: Text('View Details'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> _checkNotificationsEnabled() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      return doc.data()?['notifications_enabled'] ?? false;
    }
    return false;
  }
}
