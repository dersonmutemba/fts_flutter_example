class Person {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String address;
  final String nationality;

  const Person(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.address,
      required this.nationality});

  factory Person.fromJSON(Map<String, dynamic> json) => Person(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: 10,
      address: json['address'],
      nationality: json['nationality']);

  Map<String, dynamic> toJSON() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'age': age,
    'address': address,
    'nationality': nationality
  };
}
