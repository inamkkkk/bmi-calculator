import 'package:flutter/foundation.dart';

class BMIModel extends ChangeNotifier {
  double? _bmi;
  String _category = '';

  double? get bmi => _bmi;
  String get category => _category;

  void calculateBMI(double height, double weight) {
    // Convert height from cm to meters
    final heightInMeters = height / 100;
    _bmi = weight / (heightInMeters * heightInMeters);

    if (_bmi! < 18.5) {
      _category = 'Underweight';
    } else if (_bmi! < 25) {
      _category = 'Healthy';
    } else if (_bmi! < 30) {
      _category = 'Overweight';
    } else {
      _category = 'Obese';
    }
    notifyListeners();
  }
}