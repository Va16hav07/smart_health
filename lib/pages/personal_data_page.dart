import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>?;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildInfoTile('First Name', userData?['firstName'] ?? 'Not set'),
              _buildInfoTile('Last Name', userData?['lastName'] ?? 'Not set'),
              _buildInfoTile('Email', userData?['email'] ?? 'Not set'),
              _buildInfoTile('Height', '${userData?['height'] ?? '--'} cm'),
              _buildInfoTile('Weight', '${userData?['weight'] ?? '--'} kg'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
