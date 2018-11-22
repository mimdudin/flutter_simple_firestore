import 'package:flutter/material.dart';
import 'package:learn_firestore/list_mahasiswa.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Data Mahasiswa',
      theme: new ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: ListMahasiswa(),
    );
  }
}