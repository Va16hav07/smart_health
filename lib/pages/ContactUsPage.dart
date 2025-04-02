import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text('Contact Us', style: TextStyle(color: Color(0xFF86E200))),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactCard(
              'Customer Support',
              'support@smarthealth.com',
              Icons.headset_mic,
            ),
            _buildContactCard(
              'Technical Support',
              'tech@smarthealth.com',
              Icons.engineering,
            ),
            _buildContactCard(
              'Feedback',
              'feedback@smarthealth.com',
              Icons.feedback,
            ),
            SizedBox(height: 24),
            Text(
              'Social Media',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(Icons.facebook, 'Facebook'),
                _buildSocialButton(Icons.telegram, 'Telegram'),
                _buildSocialButton(Icons.discord, 'Discord'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String title, String email, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF86E200), size: 32),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 4),
              Text(email, style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF2B2B2B),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFF86E200), size: 24),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
