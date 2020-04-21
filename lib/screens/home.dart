import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterFirebaseCrud/models/post.dart';
import 'package:flutterFirebaseCrud/screens/home_drawer.dart';
import 'package:flutterFirebaseCrud/screens/login.dart';
import 'package:flutterFirebaseCrud/screens/new_post.dart';
import 'package:flutterFirebaseCrud/screens/show_posts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context); 
    final posts = Provider.of<List<Post>>(context) ?? [];
    final bool isAuthenticated = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: HomeDrawer(),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              posts[index].title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowPosts(post: posts[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isAuthenticated) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPost(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogIn(),
              ),
            );
          }
        },
        tooltip: isAuthenticated ? 'Yeni Post' : 'Login',
        child: isAuthenticated
            ? Icon(Icons.note_add)
            : Icon(Icons.settings_backup_restore),
      ),
    );
  }
}
