import 'package:flutter/material.dart';
import 'package:flutter_drift_sample/src/drift/todos.dart';
import 'package:flutter_drift_sample/drift_sample.dart';

void main() {
  final database = MyDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});
  final MyDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DriftSample(database: database),
    );
  }
}
