import 'package:flutter/material.dart';
import 'package:smart_health/pages/AchievementsPage.dart';
import 'package:smart_health/pages/PersonalDetailsPage.dart';
import '../widgets/CustomBottomNavBar.dart';
import 'ActivityHistoryPage.dart';
import 'WorkoutProgressPage.dart';
import 'SettingsPage.dart';
import 'ContactUsPage.dart';
import 'PrivacyPolicyPage.dart';
import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentProfileImage = 'assets/profile/profile1.jpg';

  final List<String> profileImages = [
    'assets/profile/profile1.jpg',
    'assets/profile/profile2.png',
    'assets/profile/profile3.png',
    'assets/profile/profile4.jpg',
  ];

  void _showProfilePictureOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF2B2B2B),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Profile Picture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: profileImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentProfileImage = profileImages[index];
                            });
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(profileImages[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 40.0, 16.0, padding.bottom + 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.04),
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: Color(0xFF2B2B2B),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GestureDetector(
                        onTap: () => _showProfilePictureOptions(context),
                        child: CircleAvatar(
                          radius: screenWidth * 0.125,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: AssetImage(currentProfileImage),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF86E200),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Vaibhav Kumawat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Vaibhav@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF86E200),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(120, 40),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Weight', '75 Kg'),
                      _buildStatItem('Age', '19'),
                      _buildStatItem('Height', '165 cm'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            _buildSettingsItem(context, 'Personal Details'),
            _buildSettingsItem(context, 'Achievement'),
            _buildSettingsItem(context, 'Activity History'),
            _buildSettingsItem(context, 'Workout Progress'),
            SizedBox(height: 24),
            Text(
              'Other',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            _buildSettingsItem(context, 'Contact Us'),
            _buildSettingsItem(context, 'Privacy Policy'),
            _buildSettingsItem(context, 'Settings'),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.5),
              Colors.black,
            ],
          ),
        ),
        child: CustomBottomNavBar(),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Color(0xFF2B2B2B),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title) {
    final Map<String, IconData> icons = {
      'Personal Details': Icons.person_outline,
      'Achievement': Icons.emoji_events_outlined,
      'Activity History': Icons.history,
      'Workout Progress': Icons.fitness_center,
      'Contact Us': Icons.mail_outline,
      'Privacy Policy': Icons.security,
      'Settings': Icons.settings,
    };

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF464646),
      ),
      child: ListTile(
        leading: Icon(
          icons[title] ?? Icons.arrow_right,
          color: Color(0xFF86E200),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: () {
          switch (title) {
            case 'Personal Details':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalDetailsPage()),
              );
              break;
            case 'Achievement':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsPage()),
              );
              break;
            case 'Activity History':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityHistoryPage()),
              );
              break;
            case 'Workout Progress':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutProgressPage()),
              );
              break;
            case 'Contact Us':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
              break;
            case 'Privacy Policy':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
              break;
            case 'Settings':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
