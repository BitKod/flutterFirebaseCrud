import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditPost'),
      ),
      body: Center(
        child: Text('Bu sayfa EditPost'),
      ),
    );
  }
}
