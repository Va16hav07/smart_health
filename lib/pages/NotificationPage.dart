import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Notifications'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF86E200),
              child: Icon(Icons.notifications, color: Colors.black),
            ),
            title: Text(
              'Workout Reminder',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Time to complete your daily workout!',
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Text('2h ago', style: TextStyle(color: Colors.white70)),
          );
        },
      ),
    );
  }
}
