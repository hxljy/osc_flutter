import 'package:flutter/material.dart';
import 'package:osc_flutter/constants/constants.dart' show AppColors;
import 'package:osc_flutter/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源中国',
      theme: ThemeData(
        primaryColor: Color(AppColors.COLOR_PRIMARY),

      ),
      home: HomePage(),
    );
  }
}