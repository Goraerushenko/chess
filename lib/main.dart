
import 'package:chess/pages/start-page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ).copyWith(),
        home: MyApp(),
      )
  );
  List<int> a = [1,2,3,4];
  var b = a;
  print(b);
  b[0] = 1000;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StartPage();
  }
}