import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_health/home/dashboard.dart';
import 'package:smart_health/pages/challenges_page.dart';
import 'package:smart_health/pages/reminders_page.dart';
import 'package:smart_health/pages/workouts_page.dart';
import 'package:smart_health/pages/settings_page.dart';
import 'package:smart_health/pages/personal_data_page.dart';
import 'package:smart_health/pages/achievement_page.dart';
import 'package:smart_health/pages/activity_history_page.dart';
import 'package:smart_health/pages/workout_progress_page.dart';
import 'package:smart_health/pages/contact_us_page.dart';
import 'package:smart_health/pages/privacy_policy_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> avatars = [
    'assets/profile/profile1.jpg',
    'assets/profile/profile2.png',
    'assets/profile/profile3.png',
    'assets/profile/profile4.jpg',
  ];

  Future<void> _changeAvatar() async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Avatar'),
            content: SizedBox(
              width: double.maxFinite,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await _firestore
                          .collection('users')
                          .doc(_auth.currentUser?.uid)
                          .update({'avatarIndex': index});
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(avatars[index]),
                    ),
                  );
                },
              ),
            ),
          ),
    );
  }

  Stream<DocumentSnapshot> getUserData() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChallengesPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RemindersPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WorkoutsPage()),
        );
        break;
      case 4:
        // Already on profile page
        break;
    }
  }

  int calculateAge(Timestamp? dateOfBirth) {
    if (dateOfBirth == null) return 0;

    final today = DateTime.now();
    final birthDate = dateOfBirth.toDate();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data?.data() as Map<String, dynamic>?;
          final avatarIndex = userData?['avatarIndex'] ?? 0;

          // Add this debug print to verify data
          print('Firestore Data: $userData');

          final firstName = userData?['firstName']?.toString() ?? '';
          final lastName = userData?['lastName']?.toString() ?? '';
          final fullName = '$firstName $lastName'.trim();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _changeAvatar,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(avatars[avatarIndex]),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF30ED30),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName.isEmpty ? 'User' : fullName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Member',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF30ED30),
                      ),
                      child: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoCard(
                      '${userData?['height'] ?? '--'}cm',
                      'Height',
                    ),
                    _buildInfoCard(
                      '${userData?['weight'] ?? '--'}kg',
                      'Weight',
                    ),
                    _buildInfoCard(
                      '${calculateAge(userData?['dateOfBirth'] as Timestamp?)}yo',
                      'Age',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _buildSection('Account', [
                  _buildListTile(
                    'Personal Data',
                    Icons.person,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalDataPage(),
                          ),
                        ),
                  ),
                  _buildListTile(
                    'Achievement',
                    Icons.emoji_events,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AchievementPage(),
                          ),
                        ),
                  ),
                  _buildListTile(
                    'Activity History',
                    Icons.access_time,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityHistoryPage(),
                          ),
                        ),
                  ),
                  _buildListTile(
                    'Workout Progress',
                    Icons.fitness_center,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WorkoutProgressPage(),
                          ),
                        ),
                  ),
                ]),
                _buildSection('Notification', [
                  SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: const Text('Pop-up Notification'),
                    secondary: const Icon(
                      Icons.notifications_active,
                       color: Color(0xFF30ED30),
                    ),
                  ),
                ]),
                _buildSection('Other', [
                  _buildListTile(
                    'Contact Us',
                    Icons.mail,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUsPage(),
                          ),
                        ),
                  ),
                  _buildListTile(
                    'Privacy Policy',
                    Icons.privacy_tip,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage(),
                          ),
                        ),
                  ),
                  _buildListTile(
                    'Settings',
                    Icons.settings,
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        ),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 4, // Profile page is now at index 4
        selectedItemColor: Color(0xFF30ED30),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon,  color: Color(0xFF30ED30)),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.1 : 0.2,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.1 : 0.2,
            ),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
               color: Color(0xFF30ED30),
            ),
          ),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
