import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text(
          'Personal Details',
          style: TextStyle(color: Color(0xFF86E200)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildDetailItem('Full Name', 'Vaibhav Kumawat'),
          _buildDetailItem('Email', 'Vaibhav@gmail.com'),
          _buildDetailItem('Phone', '+91 1234567890'),
          _buildDetailItem('Date of Birth', '07/06/2005'),
          _buildDetailItem('Gender', 'Male'),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
