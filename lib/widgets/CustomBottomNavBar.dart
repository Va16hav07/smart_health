import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      color: Colors.transparent, // Make outer container transparent
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
              _buildNavItem(Icons.notifications_rounded, 2),
              _buildNavItem(Icons.fitness_center_rounded, 3),
              _buildNavItem(Icons.person_rounded, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color:
              _selectedIndex == index ? Color(0xFF30ED30) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: _selectedIndex == index ? 24 : 16,
        ),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.black : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
