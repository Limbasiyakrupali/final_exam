import 'dart:async';

import 'package:flutter/material.dart';

class Splashscreens extends StatefulWidget {
  const Splashscreens({super.key});

  @override
  State<Splashscreens> createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushNamed("home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/premium-vector/clock-icon-3d-vector-illustration_68747-286.jpg"))),
      ),
    ));
  }
}
