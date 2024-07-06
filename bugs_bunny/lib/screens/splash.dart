import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bugs_bunny/screens/home.dart'; // Assuming this is where HomeScreen is defined

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2, milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 175),
            Hero(
              tag: "num",
              child: Image.asset(
                'assets/logo.png', // Replace with your image asset
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              "Bugs Bunny\nThe Bug Tracking Tool",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'LemonJelly', // Use the 'Pacifico' font family
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 120),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}
