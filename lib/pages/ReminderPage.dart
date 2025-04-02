import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Reminders', style: TextStyle(color: Color(0xFF86E200))),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF86E200).withOpacity(0.2),
                child: Icon(Icons.alarm, color: Color(0xFF86E200)),
              ),
              title: Text(
                'Daily Workout',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '7:00 AM - Every day',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Switch(
                value: true,
                activeColor: Color(0xFF86E200),
                onChanged: (value) {},
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
