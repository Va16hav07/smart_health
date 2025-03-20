import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_health/home/dashboard.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class ProfileCompletionPage extends StatefulWidget {
  final String userId;
  const ProfileCompletionPage({super.key, required this.userId});

  @override
  State<ProfileCompletionPage> createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  final _firestore = FirebaseFirestore.instance;
  String? _selectedGender;
  DateTime? _dateOfBirth;
  bool _isLoading = false;
  int _selectedWeight = 60;
  int _selectedHeight = 170;

  Future<void> _selectDate(BuildContext context) async {
    final List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: const Color(0xFF30ED30),
        lastDate: DateTime.now(),
        firstDate: DateTime(1900),
      ),
      dialogSize: const Size(325, 400),
      value: _dateOfBirth != null ? [_dateOfBirth] : [],
    );

    if (picked != null && picked.isNotEmpty && picked[0] != null) {
      setState(() => _dateOfBirth = picked[0]!);
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    try {
      await _firestore.collection('users').doc(widget.userId).update({
        'gender': _selectedGender,
        'dateOfBirth':
            _dateOfBirth != null ? Timestamp.fromDate(_dateOfBirth!) : null,
        'weight': _selectedWeight.toDouble(),
        'height': _selectedHeight.toDouble(),
        'profileCompleted': true,
      });
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showWeightPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Select Weight (kg)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: WheelChooser.integer(
                          onValueChanged:
                              (value) =>
                                  setState(() => _selectedWeight = value),
                          maxValue: 200,
                          minValue: 20,
                          initValue: _selectedWeight,
                          selectTextStyle: const TextStyle(
                            color: Color(0xFF30ED30),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('kg', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF30ED30),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showHeightPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Select Height (cm)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: WheelChooser.integer(
                          onValueChanged:
                              (value) =>
                                  setState(() => _selectedHeight = value),
                          maxValue: 250,
                          minValue: 100,
                          initValue: _selectedHeight,
                          selectTextStyle: const TextStyle(
                            color: Color(0xFF30ED30),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('cm', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF30ED30),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/completereg.png', // Save your image as assets/background.png
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Let's complete your profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'It will help us to know more about you!',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // Gender Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        border: InputBorder.none,
                        hintText: 'Choose Gender',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(value: 'Other', child: Text('Other')),
                      ],
                      onChanged:
                          (value) => setState(() => _selectedGender = value),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Date of Birth
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today),
                        hintText:
                            _dateOfBirth == null
                                ? 'Date of Birth'
                                : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Weight Selection
                  InkWell(
                    onTap: _showWeightPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.monitor_weight, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(
                            'Weight: $_selectedWeight kg',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Height Selection
                  InkWell(
                    onTap: _showHeightPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.height, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(
                            'Height: $_selectedHeight cm',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Next Button
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF30ED30),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
