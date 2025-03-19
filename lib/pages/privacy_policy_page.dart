import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Last updated: January 2024\n\n'
            'This Privacy Policy describes Our policies and procedures on the collection, '
            'use and disclosure of Your information when You use the Service.\n\n'
            'We use Your Personal data to provide and improve the Service. By using the Service, '
            'You agree to the collection and use of information in accordance with this Privacy Policy.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
