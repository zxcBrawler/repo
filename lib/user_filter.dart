import 'dart:io';
import 'package:pr1_project/models/student.dart';
import 'package:pr1_project/repository/student_repository.dart';
import 'package:pr1_project/repository/strings.dart';
import 'package:pr1_project/user_actions.dart';

List<Student> _filteredList = [];
Student student = Student();
String? groupName;

List<Student> filterListByParameter(parameter) {
  switch (parameter) {
    case "1.1":
      _filteredList = studentRepo
          .where((student) => student.grade! >= 4.5 && student.grade! <= 5.0)
          .toList();
      break;
    case "1.2":
      _filteredList = studentRepo
          .where((student) => student.grade! >= 3.5 && student.grade! <= 4.49)
          .toList();
      break;
    case "1.3":
      _filteredList = studentRepo
          .where((student) => student.grade! >= 2.5 && student.grade! <= 3.49)
          .toList();
      break;
    case "1.4":
      _filteredList =
          studentRepo.where((student) => student.grade! < 2.49).toList();
      break;
    case "2":
      _filteredList =
          studentRepo.where((student) => student.group == groupName).toList();
      break;
    case "3.1":
      _filteredList = studentRepo.where((student) => student.age < 18).toList();
      break;
    case "3.2":
      _filteredList =
          studentRepo.where((student) => student.age >= 18).toList();
      break;
    default:
      noSuchOption;
  }

  return _filteredList;
}

String? filterMenu() {
  print(filterMenuString);
  var option = stdin.readLineSync();

  switch (option) {
    case "1.1":
      return "1.1";
    case "1.2":
      return "1.2";
    case "1.3":
      return "1.3";
    case "1.4":
      return "1.4";
    case "2":
      groupName = stdin.readLineSync();
      return "2";
    case "3.1":
      return "3.1";
    case "3.2":
      return "3.2";
    case "exit":
      mainMenu();
    default:
      return noSuchOption;
  }
  return null;
}
