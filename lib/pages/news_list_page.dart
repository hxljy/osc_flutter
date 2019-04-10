import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => new _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text('资讯'),
      ),
    );
  }
}
