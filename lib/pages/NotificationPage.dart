import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(color: Color(0xFF86E200)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            _buildNotificationItem(
              "New workout is Available",
              "June 10 - 10:00 AM",
              Icons.fitness_center,
              Colors.orange,
            ),
            SizedBox(height: 12),
            _buildNotificationItem(
              "Don't forget to drink water",
              "June 10 - 8:00 AM",
              Icons.water_drop,
              Colors.blue,
            ),
            SizedBox(height: 24),
            Text(
              "Yesterday",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            _buildNotificationItem(
              "Remember Your Exercise Session",
              "June 09 - 6:00 PM",
              Icons.timer,
              Colors.purple,
            ),
            SizedBox(height: 12),
            _buildNotificationItem(
              "New Article & Tip posted!",
              "June 09 - 3:00 PM",
              Icons.article,
              Colors.green,
            ),
            SizedBox(height: 12),
            _buildNotificationItem(
              "Upper Body Workout Completed!",
              "June 09 - 11:00 AM",
              Icons.emoji_events,
              Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String time,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: Color(0xff2b2b2b),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.2),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
