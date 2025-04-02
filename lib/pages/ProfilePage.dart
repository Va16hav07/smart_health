import 'package:flutter/material.dart';
import '../widgets/CustomBottomNavBar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Profile'),
        automaticallyImplyLeading: false, 
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF86E200),
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            SizedBox(height: 16),
            Text(
              'Vaibhav',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            _buildProfileItem(Icons.person, 'Personal Information'),
            _buildProfileItem(Icons.settings, 'Settings'),
            _buildProfileItem(Icons.history, 'Activity History'),
            _buildProfileItem(Icons.help, 'Help & Support'),
            _buildProfileItem(Icons.logout, 'Logout'),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF86E200)),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
      onTap: () {},
    );
  }
}
