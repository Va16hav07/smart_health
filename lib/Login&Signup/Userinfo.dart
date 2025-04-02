import 'package:flutter/material.dart';
import 'package:smart_health/Login&Signup/welcome.dart';

void main() {
  runApp(UserInfoApp());
}

class UserInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserInfoScreen(),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String? selectedGender;
  DateTime? selectedDate;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController nameController =
      TextEditingController(); // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/userinfo.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "It will help us to know more about you!",
                    style: TextStyle(color: Color(0xFF7B6F72), fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildInputField(
                    "Enter Your Name",
                    "",
                    nameController,
                  ), // Add this line
                  _buildDropdown(),
                  _buildDatePicker(),
                  _buildInputField("Enter Your Weight", "KG", weightController),
                  _buildInputField("Enter Your Height", "CM", heightController),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => WelcomePage(
                                    userName:
                                        nameController.text.isNotEmpty
                                            ? nameController.text
                                            : 'User',
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF86E200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF86E200).withOpacity(0.3)),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: selectedGender,
          hint: Row(
            children: [
              Icon(Icons.wc, color: Color(0xFF86E200), size: 22),
              SizedBox(width: 10),
              Text(
                "Choose your Gender",
                style: TextStyle(
                  color: Color(0xFF7B6F72),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          isExpanded: true,
          dropdownColor: Colors.grey[900],
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF86E200).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_drop_down, color: Color(0xFF86E200)),
          ),
          underline: SizedBox(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          items:
              ["Male", "Female", "Other"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xFF86E200),
                  onPrimary: Colors.black,
                  surface: Colors.grey[900]!,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: Colors.grey[900],
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF86E200),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF86E200).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF86E200).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today,
                color: Color(0xFF86E200),
                size: 20,
              ),
            ),
            SizedBox(width: 10),
            Text(
              selectedDate == null
                  ? "Date of Birth"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: TextStyle(
                color: selectedDate == null ? Color(0xFF7B6F72) : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String unit,
    TextEditingController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF86E200).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF86E200).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              label.contains("Weight")
                  ? Icons.monitor_weight_outlined
                  : Icons.height,
              color: Color(0xFF86E200),
              size: 20,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              cursorColor: Color(0xFF86E200),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xFF86E200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              unit,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
