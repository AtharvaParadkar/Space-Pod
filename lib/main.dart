import 'package:flutter/material.dart';
import 'package:space_pod/pages/home_page.dart';

void main() => runApp(SpacePod());

class SpacePod extends StatelessWidget {
  const SpacePod({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "SixtyFour",
        brightness: .dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Color(0xff000064),
      ),
      home: HomePage(),
    );
  }
}
