import 'package:flutter_test/flutter_test.dart';
import 'package:grade_tool_assignment/grade_calculator.dart';

void main() {
  final gradeDictionary = {98: "A", 87: "B", 40: "F"};
  for (final entry in gradeDictionary.entries) {
    int gradeScore = entry.key;
    String gradeLetter = entry.value;
    test(('$gradeScore is $gradeLetter'), () {
      final calculator = GradeCalculator();
      String result = calculator.defineGrade(gradeScore);
      expect(gradeLetter, result);
    });
  }
}

void expect(String gradeLetter, String letter) {}
