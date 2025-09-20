import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/models/bmi_model.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final height = double.tryParse(heightController.text);
                final weight = double.tryParse(weightController.text);

                if (height != null && weight != null) {
                  Provider.of<BMIModel>(context, listen: false).calculateBMI(height, weight);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid height and weight.')),
                  );
                }
              },
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            Consumer<BMIModel>(
              builder: (context, bmiModel, child) {
                if (bmiModel.bmi != null) {
                  return Column(
                    children: [
                      Text('BMI: ${bmiModel.bmi!.toStringAsFixed(2)}'),
                      Text('Category: ${bmiModel.category}'),
                    ],
                  );
                } else {
                  return const Text('Enter height and weight to calculate BMI.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}