import 'package:flutter/material.dart';
import '../pages/ChallengesPage.dart';
import '../pages/ProfilePage.dart';
import '../pages/NotificationPage.dart';
import '../Home/Dashboard.dart';
import '../pages/WorkoutPage.dart'; 
import '../controllers/NavigationController.dart';
import '../pages/ReminderPage.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final NavigationController _controller = NavigationController();

  void _onItemTapped(int index, BuildContext context) {
    _controller.setIndex(index);

    switch (index) {
      case 0:
        if (!(context.widget is DashboardPage)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
        break;
      case 1:
        if (!(context.widget is ChallengesPage)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChallengesPage()),
          );
        }
        break;
      case 2:
        if (!(context.widget is ReminderPage)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ReminderPage()),
          );
        }
        break;
      case 3:
        if (!(context.widget is WorkoutPage)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WorkoutPage()),
          );
        }
        break;
      case 4:
        if (!(context.widget is ProfilePage)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Container(
          height: 100,
          color: Colors.transparent, 
          child: Center(
            child: Container(
              width: screenWidth * 0.9,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
              decoration: BoxDecoration(
                color: Color(0xFF192126),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 4,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: screenWidth * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_rounded, 0),
                  _buildNavItem(Icons.emoji_events_rounded, 1),
                  _buildNavItem(
                    Icons.alarm_rounded,
                    2,
                  ), 
                  _buildNavItem(Icons.fitness_center_rounded, 3),
                  _buildNavItem(Icons.person_rounded, 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index, context),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color:
              _controller.selectedIndex == index
                  ? Color(0xFF86E200)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: _controller.selectedIndex == index ? 24 : 16,
        ),
        child: Icon(
          icon,
          color:
              _controller.selectedIndex == index ? Colors.black : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
