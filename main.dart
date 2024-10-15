import 'package:flutter/material.dart';
import 'pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      title: 'Weather App',
     
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      
        appBarTheme: const AppBarTheme(
       backgroundColor: Color.fromARGB(255, 148, 204, 249), // AppBar background color globally
    ),
    ),
      home: HomePage(),
    );
  }
}
