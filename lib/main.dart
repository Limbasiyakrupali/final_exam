import 'package:final_exam/view/screens/homepage.dart';
import 'package:final_exam/view/screens/splashscreens.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => Splashscreens(),
      'home': (context) => Homepage(),
    },
  ));
}
