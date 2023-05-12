import 'package:flutter/material.dart';
import 'package:fts_flutter_example/database.dart';
import 'package:fts_flutter_example/search.dart';

import 'person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    DatabaseImplementation database = DatabaseImplementation();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController nationalityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: firstNameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: lastNameController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            TextField(
              controller: nationalityController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            ElevatedButton(
                onPressed: () {
                  database.insert(Person(
                      id: DateTime.now().toIso8601String(),
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      age: int.parse(ageController.text),
                      address: addressController.text,
                      nationality: nationalityController.text));
                  firstNameController.text = '';
                  lastNameController.text = '';
                  ageController.text = '';
                  addressController.text = '';
                  nationalityController.text = '';
                },
                child: const Text('Register')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const Search())),
        tooltip: 'Search',
        child: const Icon(Icons.turn_right_rounded),
      ),
    );
  }
}
