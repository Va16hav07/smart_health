import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Color(0xFF86E200)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSection(
            'Introduction',
            'Welcome to Smart Health. This privacy policy explains how we collect, use, and protect your personal information.',
          ),
          _buildSection(
            'Data Collection',
            'We collect information that you provide directly to us, including your name, email address, and health-related data.',
          ),
          _buildSection(
            'Data Usage',
            'We use your data to provide personalized workout recommendations and track your fitness progress.',
          ),
          _buildSection(
            'Data Protection',
            'We implement various security measures to protect your personal information from unauthorized access or disclosure.',
          ),
          _buildSection(
            'Your Rights',
            'You have the right to access, modify, or delete your personal information at any time.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF86E200),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
