import 'package:flutter/material.dart';

class WorkoutProgressPage extends StatelessWidget {
  const WorkoutProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Progress'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProgressCard('Weekly Goal', '4/5 workouts', 0.8),
          _buildProgressCard('Monthly Goal', '16/20 workouts', 0.8),
          _buildProgressCard('Calories Burned', '2500/3000 kcal', 0.83),
          _buildProgressCard('Active Minutes', '180/200 mins', 0.9),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String title, String progress, double value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(progress),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
