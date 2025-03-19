import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactCard(
              'Customer Support',
              'support@smarthealth.com',
              Icons.support_agent,
            ),
            _buildContactCard(
              'Technical Support',
              'tech@smarthealth.com',
              Icons.engineering,
            ),
            _buildContactCard('Phone', '+1 234 567 890', Icons.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String title, String detail, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title),
        subtitle: Text(detail),
      ),
    );
  }
}
