import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF86E200)),
        title: Text('Settings', style: TextStyle(color: Color(0xFF86E200))),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSettingSwitch('Notifications', notificationsEnabled, (value) {
            setState(() => notificationsEnabled = value);
          }),
          _buildSettingSwitch('Dark Mode', darkMode, (value) {
            setState(() => darkMode = value);
          }),
          _buildSettingItem('Language', 'English'),
          _buildSettingItem('Units', 'Metric'),
          _buildSettingItem('App Version', '1.0.0'),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF86E200),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(value, style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}
