import 'package:flutter/material.dart';

void main() {
  runApp(const BMIBasicApp());
}

/// The root widget of the BMI Basic application.
class BMIBasicApp extends StatelessWidget {
  const BMIBasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator Basic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const BMIScreen(),
    );
  }
}

/// The main screen for calculating BMI.
class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  // Controllers for handling input text
  final _heightController = TextEditingController(text: '175');
  final _weightController = TextEditingController(text: '68');
  
  // State variables for calculation results
  double? _bmi;
  String _status = '';
  Color _statusColor = Colors.black;
  
  // Validation state
  bool _isFormValid = true;

  @override
  void initState() {
    super.initState();
    // Register listeners to validate the form as the user types
    _heightController.addListener(_validateForm);
    _weightController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is removed from the tree
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  /// Checks if both input fields are non-empty and updates the UI state.
  void _validateForm() {
    final isValid = _heightController.text.isNotEmpty && _weightController.text.isNotEmpty;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  /// Performs the BMI calculation and updates the status based on the result.
  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      setState(() {
        // Formula: BMI = weight (kg) / height (m)^2
        _bmi = weight / ((height / 100) * (height / 100));
        
        // Determine weight category based on standard BMI ranges
        if (_bmi! < 18.5) {
          _status = 'Underweight';
          _statusColor = Colors.orange;
        } else if (_bmi! < 25) {
          _status = 'Normal Weight';
          _statusColor = Colors.green;
        } else if (_bmi! < 30) {
          _status = 'Overweight';
          _statusColor = Colors.orange;
        } else {
          _status = 'Obese';
          _statusColor = Colors.red;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Enter your details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            
            // Height Input Card
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.height, size: 30, color: Colors.grey),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Height (cm)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Weight Input Card
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.monitor_weight_outlined, size: 30, color: Colors.grey),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Weight (kg)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Conditional Error Message for Validation
            if (!_isFormValid) ...[
              const SizedBox(height: 8),
              const Text(
                'Please enter both height and weight',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
            const SizedBox(height: 16),

            // Calculate Button - Disabled if form is invalid
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isFormValid ? _calculateBMI : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[500],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('CALCULATE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            // Result Display Area
            if (_bmi != null) ...[
              const SizedBox(height: 60),
              const Text(
                'Your BMI is',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                _bmi!.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                _status,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _statusColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '18.5 - 24.9 is considered a healthy range.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
