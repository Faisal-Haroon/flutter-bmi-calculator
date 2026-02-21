// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key});

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String category = '';
  String result = '';

  void calculateBmi() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      return;
    }

    try {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      if (weight <= 0 || height <= 0) {
        return;
      }

      double bmi = weight / (height * height);

      setState(() {
        result = bmi.toStringAsFixed(2);

        if (bmi < 18.5) {
          category = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 25) {
          category = 'Normal';
        } else if (bmi >= 25 && bmi < 30) {
          category = 'Overweight';
        } else {
          category = 'Obese';
        }
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to BMI Calculator',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 30),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: 'Enter weight in kg',
                  border: OutlineInputBorder(),
        
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
        
              SizedBox(height: 20),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: 'Enter Height in cm',
                  border: OutlineInputBorder(),
        
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
        
              SizedBox(height: 20),
        
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  calculateBmi();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
        
              SizedBox(height: 20),
              Text('BMI:$result'),
              SizedBox(height: 10),
              Text('Category:$category'),
            ],
          ),
        ),
      ),
    );
  }
}
