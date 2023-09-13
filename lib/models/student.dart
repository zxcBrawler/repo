class Student {
  late int id;
  late String surname;
  late String? middleName;
  late String firstName;
  late int age;
  late String group;
  late double? grade;

  Student.fullInfo(this.id, this.middleName, this.firstName, this.grade,
      {required this.age, required this.group, required this.surname});

  Student.onlyGroupAndSurname(this.surname, this.group);

  Student.forChange(this.id, this.firstName, this.surname, this.middleName,
      this.group, this.grade, this.age);

  Student();

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'surname': surname,
        'middleName': middleName,
        'group': group,
        'grade': grade,
        'age': age,
      };
}
