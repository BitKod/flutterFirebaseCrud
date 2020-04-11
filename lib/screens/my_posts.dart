import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPosts'),
      ),
      body: Center(
        child: Text('Bu sayfa MyPosts'),
      ),
    );
  }
}
