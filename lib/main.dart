import 'package:crypto_karami/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'omidfont'),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
