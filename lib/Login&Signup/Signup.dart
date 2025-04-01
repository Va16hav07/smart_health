import 'package:flutter/material.dart';
import 'Userinfo.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hey there,",
                style: TextStyle(color: Colors.white, fontSize: 27),
                textAlign: TextAlign.center,
              ),
              Text(
                "Create an Account",
                style: TextStyle(
                  color: Color(0xFF86E200),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField("First Name"),
              _buildTextField("Last Name"),
              _buildTextField("E-mail Address"),
              _buildTextField(
                "Password",
                isPassword: true,
                isPasswordVisible: _passwordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              _buildTextField(
                "Confirm Password",
                isPassword: true,
                isPasswordVisible: _confirmPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF86E200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120,
                    vertical: 15,
                  ),
                ),
                child: Text("Sign Up", style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              Text("or sign up with", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                icon: Image.asset(
                  'assets/icons/google.png',
                  height: 24,
                  width: 24,
                ),
                label: Text(
                  "Signup with Google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Color(0xFF86E200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText, {
    bool isPassword = false,
    bool? isPasswordVisible,
    VoidCallback? onVisibilityToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword ? !isPasswordVisible! : false,
        style: TextStyle(color: Color(0xFFB1B1B1)),
        cursorColor: Color(0xFF86E200),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFB1B1B1)),
          filled: true,
          fillColor: Color(0xFF2B2B2B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF86E200)),
          ),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      isPasswordVisible!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFF86E200),
                    ),
                    onPressed: onVisibilityToggle,
                  )
                  : null,
        ),
      ),
    );
  }
}
