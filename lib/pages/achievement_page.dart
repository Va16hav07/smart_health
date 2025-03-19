import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  const AchievementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAchievementCard(
            'First Workout',
            'Completed your first workout',
            Icons.fitness_center,
          ),
          _buildAchievementCard(
            'Early Bird',
            'Completed morning workout',
            Icons.wb_sunny,
          ),
          _buildAchievementCard(
            'Streak Master',
            '7 days workout streak',
            Icons.local_fire_department,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 32),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
