import 'package:flutter/material.dart';

class ActivityHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text(
          'Activity History',
          style: TextStyle(color: Color(0xFF86E200)),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Color(0xFF2B2B2B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF86E200).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.fitness_center, color: Color(0xFF86E200)),
              ),
              title: Text(
                'Workout Session ${10 - index}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Duration: 45 minutes',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    'Calories: 320 kcal',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              trailing: Text(
                '${DateTime.now().subtract(Duration(days: index)).toString().substring(0, 10)}',
                style: TextStyle(color: Color(0xFF86E200)),
              ),
            ),
          );
        },
      ),
    );
  }
}
