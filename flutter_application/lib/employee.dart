class Employee {
  final String name;
  final String description;
  final bool active;


  Employee({this.name = '', this.description = '', this.active = false});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      description: json['description'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'description': description,
    'active': active,
  };
}