import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class ChallengesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Challenges', style: TextStyle(color: Color(0xFF86E200))),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildChallengeCard(
            'Weekly Push-up Challenge',
            '500 push-ups in 7 days',
            0.6,
            '4 days left',
          ),
          _buildChallengeCard(
            '10K Steps Daily',
            'Walk 10,000 steps every day',
            0.8,
            '2 days left',
          ),
          _buildChallengeCard(
            'Weight Loss Challenge',
            'Lose 2kg in 30 days',
            0.3,
            '21 days left',
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildChallengeCard(
    String title,
    String description,
    double progress,
    String timeLeft,
  ) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF86E200),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(description, style: TextStyle(color: Colors.white70)),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF86E200)),
            ),
            SizedBox(height: 8),
            Text(timeLeft, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
