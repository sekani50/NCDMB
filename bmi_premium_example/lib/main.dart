import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const BMIPremiumApp());
}

class BMIPremiumApp extends StatelessWidget {
  const BMIPremiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF03DAC6),
        ),
        useMaterial3: true,
      ),
      home: const PremiumBMIScreen(),
    );
  }
}

class PremiumBMIScreen extends StatefulWidget {
  const PremiumBMIScreen({super.key});

  @override
  State<PremiumBMIScreen> createState() => _PremiumBMIScreenState();
}

class _PremiumBMIScreenState extends State<PremiumBMIScreen> {
  double _height = 170;
  double _weight = 70;
  int _age = 25;
  bool _isMale = true;

  double get bmi => _weight / math.pow(_height / 100, 2);

  String get status {
    if (bmi < 18.5) return 'UNDERWEIGHT';
    if (bmi < 25) return 'NORMAL';
    if (bmi < 30) return 'OVERWEIGHT';
    return 'OBESE';
  }

  Color get statusColor {
    if (bmi < 18.5) return Colors.blueAccent;
    if (bmi < 25) return const Color(0xFF24D876);
    if (bmi < 30) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR', style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gender Selection
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: PremiumCard(
                      onTap: () => setState(() => _isMale = true),
                      color: _isMale ? const Color(0xFF1D1E33) : const Color(0xFF111328),
                      child: GenderContent(icon: Icons.male, label: 'MALE', isActive: _isMale),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PremiumCard(
                      onTap: () => setState(() => _isMale = false),
                      color: !_isMale ? const Color(0xFF1D1E33) : const Color(0xFF111328),
                      child: GenderContent(icon: Icons.female, label: 'FEMALE', isActive: !_isMale),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Height Slider
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: PremiumCard(
                color: const Color(0xFF1D1E33),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('HEIGHT', style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(_height.round().toString(), style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900)),
                        const Text('cm', style: TextStyle(color: Color(0xFF8D8E98))),
                      ],
                    ),
                    Slider(
                      value: _height,
                      min: 120,
                      max: 220,
                      activeColor: const Color(0xFFEB1555),
                      inactiveColor: const Color(0xFF8D8E98),
                      onChanged: (val) => setState(() => _height = val),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Weight and Age
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: PremiumCard(
                      color: const Color(0xFF1D1E33),
                      child: CounterContent(
                        label: 'WEIGHT',
                        value: _weight.round(),
                        onIncrement: () => setState(() => _weight++),
                        onDecrement: () => setState(() => _weight--),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PremiumCard(
                      color: const Color(0xFF1D1E33),
                      child: CounterContent(
                        label: 'AGE',
                        value: _age,
                        onIncrement: () => setState(() => _age++),
                        onDecrement: () => setState(() => _age--),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Calculate Button (Result Overlay)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ResultSheet(bmi: bmi, status: status, color: statusColor),
              );
            },
            child: Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 80,
              child: const Center(
                child: Text('CALCULATE', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  const PremiumCard({super.key, required this.child, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class GenderContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const GenderContent({super.key, required this.icon, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: isActive ? Colors.white : const Color(0xFF8D8E98)),
        const SizedBox(height: 15),
        Text(label, style: TextStyle(fontSize: 18, color: isActive ? Colors.white : const Color(0xFF8D8E98))),
      ],
    );
  }
}

class CounterContent extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterContent({super.key, required this.label, required this.value, required this.onIncrement, required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8D8E98), fontSize: 18)),
        Text(value.toString(), style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w900)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundIconButton(icon: Icons.remove, onPressed: onDecrement),
            const SizedBox(width: 10),
            RoundIconButton(icon: Icons.add, onPressed: onIncrement),
          ],
        ),
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}

class ResultSheet extends StatelessWidget {
  final double bmi;
  final String status;
  final Color color;

  const ResultSheet({super.key, required this.bmi, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Color(0xFF1D1E33),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('YOUR RESULT', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Text(status, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
          Text(bmi.toStringAsFixed(1), style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold)),
          const Column(
            children: [
              Text('Normal BMI range:', style: TextStyle(color: Color(0xFF8D8E98), fontSize: 18)),
              Text('18.5 - 25 kg/m²', style: TextStyle(fontSize: 18)),
            ],
          ),
          Text(
            _getMessage(status),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEB1555),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('RE-CALCULATE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  String _getMessage(String status) {
    switch (status) {
      case 'NORMAL': return 'You have a normal body weight. Good job!';
      case 'UNDERWEIGHT': return 'You are lower than normal. Maybe eat a bit more?';
      case 'OVERWEIGHT': return 'You are higher than normal. Try to exercise more.';
      default: return 'You have a high body weight. Consult a doctor.';
    }
  }
}
