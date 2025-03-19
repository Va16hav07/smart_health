import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../pages/challenges_page.dart';
import '../pages/reminders_page.dart';
import '../pages/workouts_page.dart';
import '../pages/profile_page.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String firstName = 'User';
  double bmi = 0.0;
  String bmiStatus = 'Loading...';
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardContent(firstName: firstName, bmi: bmi, bmiStatus: bmiStatus),
      ChallengesPage(),
      RemindersPage(),
      WorkoutsPage(),
      ProfilePage(),
    ];
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userData.exists) {
          double height =
              (userData.data()?['height'] ?? 0).toDouble(); // height in cm
          double weight =
              (userData.data()?['weight'] ?? 0).toDouble(); // weight in kg

          // Calculate BMI = weight(kg) / (height(m))²
          double heightInMeters = height / 100;
          double calculatedBmi = weight / (heightInMeters * heightInMeters);

          String status;
          if (calculatedBmi < 18.5) {
            status = 'You are underweight';
          } else if (calculatedBmi < 25) {
            status = 'You have a normal weight';
          } else if (calculatedBmi < 30) {
            status = 'You are overweight';
          } else {
            status = 'You are obese';
          }

          setState(() {
            firstName = userData.data()?['firstName'] ?? 'User';
            bmi = calculatedBmi;
            bmiStatus = status;
            // Update pages in a safer way
            _pages = [
              DashboardContent(
                firstName: firstName,
                bmi: bmi,
                bmiStatus: bmiStatus,
              ),
              ChallengesPage(),
              RemindersPage(),
              WorkoutsPage(),
              ProfilePage(),
            ];
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  label: 'Challenges',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Reminders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Workouts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              selectedItemColor: Color(0xFF30EC30),
              unselectedItemColor: Colors.grey.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  final String firstName;
  final double bmi;
  final String bmiStatus;

  DashboardContent({
    this.firstName = 'User',
    this.bmi = 0.0,
    this.bmiStatus = 'Loading...',
  });

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildBMICard(),
              const SizedBox(height: 20),
              _buildDetailedActivityStatus(),
              const SizedBox(height: 20),
              _buildWorkoutProgress(),
              const SizedBox(height: 20),
              _buildTodayTarget(),
              const SizedBox(height: 20),
              _buildWorkoutSection(),
              const SizedBox(height: 20),
              _buildActivityStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            Text(
              widget.firstName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF7F8F8),
          ),
          child: Icon(Icons.notifications_outlined),
        ),
      ],
    );
  }

  Widget _buildActivityCard(
    String title,
    String value, {
    required Color color,
    required double width,
    required double height,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActivityCard(
            'Heart Rate',
            '78 BPM',
            color: Color(0xFF30EC30),
            width: 150,
            height: 150,
          ),
          _buildActivityCard(
            'Water Intake',
            '4 Liters',
            color: Colors.blue,
            width: 150,
            height: 150,
          ),
          _buildActivityCard(
            'Sleep',
            '8h 20m',
            color: Colors.purple,
            width: 150,
            height: 150,
          ),
          _buildActivityCard(
            'Calories',
            '760 kCal',
            color: Colors.orange,
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String duration, double progress) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF7F8F8),
              borderRadius: BorderRadius.circular(12),
            ),
            // Add workout icon here
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  duration,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFFF7F8F8),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5 * progress,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF30EC30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Workout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'See more',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF30EC30),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildWorkoutCard(
          'Fullbody Workout',
          '180 Calories Burn | 20minutes',
          0.33,
        ),
        _buildWorkoutCard('Ab Workout', '180 Calories Burn | 20minutes', 0.33),
        _buildWorkoutCard(
          'Lowerbody Workout',
          '200 Calories Burn | 30minutes',
          0.55,
        ),
      ],
    );
  }

  Widget _buildWorkoutProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Workout Progress',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF30EC30),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Weekly',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Add your chart widget here
      ],
    );
  }

  Widget _buildTodayTarget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFF30EC30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today Target',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Check'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 146,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFF30EC30), Color(0xFF30EC30).withOpacity(0.8)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI (Body Mass Index)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.bmiStatus,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF5F825C),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'View More',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          CustomPaint(
            size: Size(88, 88),
            painter: BmiPieChart(
              percentage: (widget.bmi / 50) * 100, // Normalize BMI value
              backgroundColor: Colors.white.withOpacity(0.2),
              activeColor: Colors.white,
            ),
            child: Container(
              width: 88,
              height: 88,
              child: Center(
                child: Text(
                  widget.bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedActivityStatus() {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(minHeight: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Activity Status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          // Heart Rate Card
          Container(
            width: double.infinity, // Use double.infinity instead of MediaQuery
            height: 146,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF30EC30),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Wrap with Expanded
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Heart Rate',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '78 BPM',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // Wrap CustomPaint in Container with fixed size
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    size: Size(100, 100),
                    painter: HeartRateChart(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              // Water Intake with larger text
              Container(
                width: (MediaQuery.of(context).size.width - 47) / 2,
                height: 200,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Water Intake',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ), // Increased from 12
                        ),
                        Text(
                          '4L',
                          style: TextStyle(
                            fontSize: 24, // Increased from 20
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80,
                      height: 100,
                      child: _buildWaterIntakeMeter(65),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              // Sleep and Calories Column with fixed heights
              Column(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 47) / 2,
                    height: 90, // Fixed height to prevent overflow
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.nightlight_round,
                          color: Colors.white,
                          size: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sleep',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '8h 20m',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Increased gap
                  Container(
                    width: (MediaQuery.of(context).size.width - 47) / 2,
                    height: 90, // Fixed height to prevent overflow
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                          size: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calories',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '760 kCal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaterIntakeMeter(double percentage) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${percentage.toInt()}%',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            width: 15,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 15,
                  height: 50 * (percentage / 100),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class BmiPieChart extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color activeColor;

  BmiPieChart({
    required this.percentage,
    required this.backgroundColor,
    required this.activeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);

    // Draw background circle
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw active arc
    final activePaint =
        Paint()
          ..color = activeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round;

    final sweepAngle = 360 * (percentage / 100) * (math.pi / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(BmiPieChart oldDelegate) =>
      oldDelegate.percentage != percentage;
}

class HeartRateChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    // Create heart rate pattern
    for (var i = 0; i < 3; i++) {
      final segment = size.width / 3;
      final x = i * segment;

      path.lineTo(x + segment * 0.2, size.height * 0.5);
      path.lineTo(x + segment * 0.3, size.height * 0.2);
      path.lineTo(x + segment * 0.4, size.height * 0.8);
      path.lineTo(x + segment * 0.5, size.height * 0.5);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
