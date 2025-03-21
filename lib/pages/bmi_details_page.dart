import 'package:flutter/material.dart';

class BMIDetailsPage extends StatelessWidget {
  final double bmi;
  final String bmiStatus;

  const BMIDetailsPage({Key? key, required this.bmi, required this.bmiStatus})
    : super(key: key);


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final padding = screenSize.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Details'),
        backgroundColor: Color(0xFF30EC30),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isTablet)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildBMICard(context)),
                          SizedBox(width: padding),
                          Expanded(child: _buildBMIScale(context)),
                        ],
                      )
                    else ...[
                      _buildBMICard(context),
                      SizedBox(height: padding),
                      _buildBMIScale(context),
                    ],
                    SizedBox(height: padding),
                    _buildBMIExplanation(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBMICard(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.04;
    final iconSize = screenSize.width * 0.08;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF30EC30),
              const Color(0xFF30EC30).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.monitor_weight_outlined,
              size: iconSize.clamp(30, 60),
              color: Colors.white,
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              'Your BMI',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize.clamp(20, 28),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(
                color: Colors.white,
                fontSize: (fontSize * 2).clamp(36, 56),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            Text(
              bmiStatus,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize.clamp(16, 24),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScale(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BMI Scale',
          style: TextStyle(
            fontSize: fontSize.clamp(18, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        _buildBMIRangeItem('Underweight', '< 18.5', Colors.blue, context),
        _buildBMIRangeItem('Normal', '18.5 - 24.9', Color(0xFF30EC30), context),
        _buildBMIRangeItem('Overweight', '25 - 29.9', Colors.orange, context),
        _buildBMIRangeItem('Obese', '≥ 30', Colors.red, context),
      ],
    );
  }

  Widget _buildBMIRangeItem(
    String label,
    String range,
    Color color,
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.035;

    IconData getIcon() {
      switch (label) {
        case 'Underweight':
          return Icons.arrow_downward;
        case 'Normal':
          return Icons.check_circle;
        case 'Overweight':
          return Icons.warning;
        case 'Obese':
          return Icons.error;
        default:
          return Icons.info;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.005),
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.03,
        vertical: screenSize.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(getIcon(), color: color, size: fontSize.clamp(16, 24)),
          SizedBox(width: screenSize.width * 0.02),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: fontSize.clamp(14, 20),
              ),
            ),
          ),
          Text(
            range,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize.clamp(14, 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMIExplanation(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.035;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF30EC30),
                  size: fontSize.clamp(20, 28),
                ),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  'What is BMI?',
                  style: TextStyle(
                    fontSize: fontSize.clamp(18, 24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.015),
            Text(
              'Body Mass Index (BMI) is a simple measurement using your height and weight to work out if your weight is healthy. '
              'The BMI calculation divides an adult\'s weight in kilograms by their height in metres squared.',
              style: TextStyle(
                fontSize: fontSize.clamp(14, 18),
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
