import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';
import '../pages/NotificationPage.dart';
import '../pages/ProfilePage.dart';
import '../controllers/NavigationController.dart';
import '../pages/AIAssistantPage.dart';

class DashboardPage extends StatelessWidget {
  final NavigationController _controller = NavigationController();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, bottomPadding + 80.0),
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
                        color: Color(0xFF86E200),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF86E200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        _controller.setIndex(
                          4,
                        ); // Set bottom nav to profile index
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF86E200),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                          size: 24,
                        ),
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
            _buildWorkoutCard('Running', '5 km per day', 85, 'Intermediate'),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AIAssistantPage()),
          );
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Color(0xFF86E200),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF86E200).withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.mic, color: Colors.black, size: 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
      width: MediaQuery.of(context).size.width * 0.5, // Reduced from 24
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
                color: Color(0xFF86E200),
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
      padding: EdgeInsets.all(24),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Steps of the Day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1800',
                    style: TextStyle(
                      color: Color(0xFF86E200),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Goal: 2000 steps',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              Container(
                width: 200,
                height: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF86E200),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: 0.8,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF86E200),
                    ),
                  ),
                ),
                Text(
                  '80%',
                  style: TextStyle(
                    color: Color(0xFF86E200),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
            Container(
              height: 40,
              width: double.infinity,
              child: _buildCustomIndicator(title, color),
            ),
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

  Widget _buildCustomIndicator(String type, Color color) {
    switch (type.toLowerCase()) {
      case 'heart rate':
        return CustomPaint(painter: HeartRatePainter(color));
      case 'water intake':
        return CustomPaint(painter: WaterBucketPainter(color));
      case 'sleep':
        return CustomPaint(painter: BedPainter(color));
      case 'calories':
        return CustomPaint(painter: FlamesPainter(color));
      default:
        return Icon(Icons.sports, color: color);
    }
  }

  Widget _buildWorkoutCard(
    String title,
    String subtitle,
    int progress,
    String level,
  ) {
    final icon = _getWorkoutIcon(title);
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF86E200).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF86E200)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress / 100,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Color(0xFF86E200),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  level,
                  style: TextStyle(
                    color: Color(0xFF86E200),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
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
      case 'running':
        return Icons.directions_run;
      default:
        return Icons.sports;
    }
  }
}

class HeartRatePainter extends CustomPainter {
  final Color color;
  HeartRatePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);

    // Draw heartbeat pattern
    double width = size.width / 12;
    path.lineTo(width * 2, size.height / 2);
    path.lineTo(width * 3, size.height / 4);
    path.lineTo(width * 4, size.height * 3 / 4);
    path.lineTo(width * 5, size.height / 4);
    path.lineTo(width * 6, size.height * 3 / 4);
    path.lineTo(width * 7, size.height / 2);
    path.lineTo(width * 12, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WaterBucketPainter extends CustomPainter {
  final Color color;
  WaterBucketPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // Draw bucket
    final bucket =
        Path()
          ..moveTo(size.width * 0.2, size.height * 0.2)
          ..lineTo(size.width * 0.2, size.height * 0.8)
          ..lineTo(size.width * 0.8, size.height * 0.8)
          ..lineTo(size.width * 0.8, size.height * 0.2);

    // Draw water waves
    final water =
        Path()
          ..moveTo(size.width * 0.2, size.height * 0.5)
          ..cubicTo(
            size.width * 0.3,
            size.height * 0.4,
            size.width * 0.5,
            size.height * 0.6,
            size.width * 0.8,
            size.height * 0.5,
          );

    canvas.drawPath(bucket, paint);
    canvas.drawPath(water, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BedPainter extends CustomPainter {
  final Color color;
  BedPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // Draw bed frame
    final bed =
        Path()
          ..moveTo(size.width * 0.1, size.height * 0.6)
          ..lineTo(size.width * 0.1, size.height * 0.8)
          ..lineTo(size.width * 0.9, size.height * 0.8)
          ..lineTo(size.width * 0.9, size.height * 0.6)
          ..lineTo(size.width * 0.1, size.height * 0.6);

    // Draw pillow
    final pillow =
        Path()
          ..moveTo(size.width * 0.2, size.height * 0.4)
          ..lineTo(size.width * 0.4, size.height * 0.4)
          ..lineTo(size.width * 0.4, size.height * 0.6)
          ..lineTo(size.width * 0.2, size.height * 0.6)
          ..close();

    canvas.drawPath(bed, paint);
    canvas.drawPath(pillow, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FlamesPainter extends CustomPainter {
  final Color color;
  FlamesPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // Draw flames
    final flame =
        Path()
          ..moveTo(size.width * 0.5, size.height * 0.8)
          ..cubicTo(
            size.width * 0.6,
            size.height * 0.6,
            size.width * 0.8,
            size.height * 0.2,
            size.width * 0.5,
            size.height * 0.2,
          )
          ..cubicTo(
            size.width * 0.4,
            size.height * 0.2,
            size.width * 0.2,
            size.height * 0.6,
            size.width * 0.5,
            size.height * 0.8,
          );

    canvas.drawPath(flame, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
