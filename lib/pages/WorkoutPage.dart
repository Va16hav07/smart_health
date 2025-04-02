import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Workouts', style: TextStyle(color: Color(0xFF86E200))),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildWorkoutCategory('Cardio Workouts'),
          _buildWorkoutItem('Running', '30 mins', '300 kcal'),
          _buildWorkoutItem('Cycling', '45 mins', '400 kcal'),

          _buildWorkoutCategory('Strength Training'),
          _buildWorkoutItem('Push-ups', '20 reps × 3 sets', '150 kcal'),
          _buildWorkoutItem('Pull-ups', '10 reps × 3 sets', '120 kcal'),

          _buildWorkoutCategory('Flexibility'),
          _buildWorkoutItem('Yoga', '20 mins', '150 kcal'),
          _buildWorkoutItem('Stretching', '15 mins', '100 kcal'),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildWorkoutCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF86E200),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWorkoutItem(String name, String duration, String calories) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFF86E200).withOpacity(0.2),
          child: Icon(Icons.fitness_center, color: Color(0xFF86E200)),
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text(duration, style: TextStyle(color: Colors.white70)),
        trailing: Text(calories, style: TextStyle(color: Color(0xFF86E200))),
      ),
    );
  }
}
