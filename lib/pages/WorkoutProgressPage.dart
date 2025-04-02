import 'package:flutter/material.dart';

class WorkoutProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text(
          'Workout Progress',
          style: TextStyle(color: Color(0xFF86E200)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard('Weekly Goal', '4/5', 'workouts completed'),
            SizedBox(height: 20),
            _buildProgressCard('Monthly Goal', '16/20', 'workouts completed'),
            SizedBox(height: 20),
            Text(
              'Recent Achievements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildAchievementsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(String title, String progress, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.8,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF86E200)),
          ),
          SizedBox(height: 16),
          Text(
            '$progress $subtitle',
            style: TextStyle(color: Color(0xFF86E200), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsList() {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2B2B2B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Color(0xFF86E200), size: 40),
                SizedBox(height: 8),
                Text(
                  'Achievement ${index + 1}',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
