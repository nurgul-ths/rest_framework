import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.sample.dart';
import '../employee.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Employee>> employees;
  final employeeListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    print('ccd');
    super.initState();
    print('____________________');
    employees = getEmployeeList();
  }

  Future<List<Employee>> getEmployeeList() async {
    // final response = await http.get(Uri.parse("${Env.URL_PREFIX}/movies/1"));
    print('reached here');

    String url = 'http://127.0.0.1:8000/movies/list/';
    http.Response response = await http.get(Uri.parse(url));
    String val = response.body;
    List<dynamic> data = jsonDecode(val);
    print(val);
    print(response);
    print('________________________________');
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Employee> employees = items.map<Employee>((json) {
      return Employee.fromJson(json);
    }).toList();

    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: employeeListKey,
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Center(
        child: FutureBuilder<List<Employee>>(
          future: employees,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    // title: Text(
                    //   data.ename,
                    //   style: TextStyle(fontSize: 20),
                    // ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}