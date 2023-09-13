import 'dart:convert';
import 'dart:io';
import 'package:pr1_project/models/student.dart';
import 'package:pr1_project/repository/student_repository.dart';
import 'package:pr1_project/repository/strings.dart';
import 'package:pr1_project/user_filter.dart';

Student addStudent(Student student) {
  studentRepo.add(Student.forChange(
      getLastUserId() + 1,
      student.firstName,
      student.surname,
      student.middleName,
      student.group,
      student.grade,
      student.age));
  print(userAdded);
  return student;
}

Student getStudentWithHighestGrade(parameter) {
  Student student = Student();
  switch (parameter) {
    case "1":
      student = studentRepo
          .reduce((value, e) => value.grade! <= e.grade! ? value : e);
      break;
    case "2":
      student = studentRepo
          .reduce((value, e) => value.grade! >= e.grade! ? value : e);
      break;
  }
  return student;
}

double getAverageGrade() {
  List<double> grades = studentRepo.map((e) => e.grade!).toList();
  // [1,2,3] = 0 + 1 = 1 + 1 = 2 + 2 = 4 + 3 = 7
  double sumOfGrades =
      grades.fold(0, (previous, current) => previous + current);
  return sumOfGrades / grades.length;
}

int getLastUserId() {
  List<int> ids = studentRepo.map((e) => e.id).toList();
  return ids.last;
}

void deleteStudentById(int userId) {
  studentRepo.removeAt(findById(studentRepo, userId));
  print("$userDeleted $userId");
}

int findById(List<Student> list, int userId) {
  return list.indexWhere((element) => element.id == userId);
}

void changeStudentData(Student student) {
  studentRepo[findById(studentRepo, student.id)] = Student.forChange(
      student.id,
      student.firstName,
      student.surname,
      student.middleName,
      student.group,
      student.grade,
      student.age);
  print("$userChanged ${student.id}");
  showAllStudents(studentRepo);
}

void showAllStudents(studentList) {
  for (var user in studentList) {
    print(jsonEncode(user));
  }
}

void mainMenu() {
  print(chooseOptions);
  var option = stdin.readLineSync();

  switch (option) {
    case "1":
      showAllStudents(studentRepo);
      showAllStudents(filterListByParameter(filterMenu()));
      mainMenu();
      break;
    case "2":
      addStudent(studentEnterData());
      showAllStudents(studentRepo);
      mainMenu();
      break;
    case "3":
      print(chooseParameter);
      var parameter = stdin.readLineSync();
      print(jsonEncode(getStudentWithHighestGrade(parameter)));
      mainMenu();
      break;
    case "4":
      print(getAverageGrade());
      mainMenu();
      break;
    case "5":
      print(enterId);
      var userId = int.parse(stdin.readLineSync()!);
      deleteStudentById(userId);
      showAllStudents(studentRepo);
      mainMenu();
      break;
    case "6":
      print(enterId);
      var userId = 0;
      userId = int.parse(stdin.readLineSync()!);
      changeStudentData(studentEnterData(userId));
      mainMenu();
      break;
    default:
      noSuchOption;
  }
}

Student studentEnterData([id]) {
  Student student = Student();
  if (id != null) {
    student.id = id;
  }
  print(enterFirstName);
  student.firstName = stdin.readLineSync()!;
  print(enterMiddleName);
  student.middleName = stdin.readLineSync();
  print(enterSurname);
  student.surname = stdin.readLineSync()!;
  print(enterAge);
  student.age = int.parse(stdin.readLineSync()!);
  print(enterGrade);
  student.grade = double.parse(stdin.readLineSync()!);
  print(enterGroupName);
  student.group = stdin.readLineSync()!;

  return student;
}
