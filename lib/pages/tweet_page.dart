import 'package:flutter/material.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => new _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('动弹'),
      ),
    );
  }
}
