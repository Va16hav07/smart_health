import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16.0,
          40.0,
          16.0,
          bottomPadding + 80.0, // Dynamic bottom padding
        ), // Increased top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Vaibhav',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "It's Time To Challenge Your Limits.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff2b2b2b),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xff2b2b2b),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            // Height, Weight and BMI section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column - Height and Weight
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildMetricCard(
                        context, // Add context parameter
                        "Height",
                        "182 cm",
                        [Color(0xffff5f6d), Color(0xffffc371)],
                      ),
                      SizedBox(height: 16),
                      _buildMetricCard(
                        context, // Add context parameter
                        "Weight",
                        "80 kg",
                        [Color(0xff12fff7), Color(0xffb3ffab)],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                _buildBMICard(context), // Add context parameter
              ],
            ),
            SizedBox(height: 16),
            _buildStepsCard(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard(
                  'Heart Rate',
                  '79 Bpm',
                  Icons.favorite,
                  Colors.redAccent,
                ),
                _buildSmallCard(
                  'Water Intake',
                  '8/10 Cups',
                  Icons.water_drop,
                  Colors.blueAccent,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard(
                  'Sleep',
                  '06h 41m',
                  Icons.bedtime,
                  Colors.purpleAccent,
                ),
                _buildSmallCard(
                  'Calories',
                  '43.35 Kcal',
                  Icons.local_fire_department,
                  Colors.orangeAccent,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Today Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildWorkoutCard(
              'Push Up',
              '50 Push up a day',
              95,
              'Intermediate',
            ),
            _buildWorkoutCard('Sit Up', '20 Sit up a day', 50, 'Beginner'),
            _buildWorkoutCard(
              'Knee Push Up',
              '20 Sit up a day',
              70,
              'Beginner',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, // Add BuildContext parameter
    String title,
    String value,
    List<Color> gradientColors,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
      height: 100, // Reduced height
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Better spacing
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 216,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xff2b2b2b),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Changed to start
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Body Mass Index (BMI)",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "24.2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16), // Reduced from 24
          Align(
            // Added Align widget
            alignment: Alignment.centerRight, // Align to right
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "You're Healthy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Spacer(), // Add spacer to push scale to bottom
          _buildBMIScale(),
        ],
      ),
    );
  }

  Widget _buildBMIScale() {
    return Column(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("15", style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("18.5", style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("25", style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("30", style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text("40", style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildStepsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Steps of the Day', style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1800/2000',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircularProgressIndicator(value: 0.8, color: Colors.greenAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(
    String title,
    String subtitle,
    int progress,
    String level,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress / 100,
            color: Colors.greenAccent,
          ),
          SizedBox(height: 8),
          Text(level, style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  IconData _getWorkoutIcon(String workoutType) {
    switch (workoutType.toLowerCase()) {
      case 'push up':
        return Icons.fitness_center;
      case 'sit up':
        return Icons.sports_gymnastics;
      case 'knee push up':
        return Icons.accessibility_new;
      default:
        return Icons.sports;
    }
  }
}
