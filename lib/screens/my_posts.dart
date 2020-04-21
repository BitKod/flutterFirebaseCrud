import 'package:flutter/material.dart';
import 'package:flutterFirebaseCrud/models/post.dart';
import 'package:flutterFirebaseCrud/screens/edit_post.dart';
import 'package:flutterFirebaseCrud/screens/new_post.dart';
import 'package:flutterFirebaseCrud/shared/loading.dart';
import 'package:flutterFirebaseCrud/services/database.dart';
import 'package:flutterFirebaseCrud/screens/show_posts.dart';

class MyPosts extends StatefulWidget {
  MyPosts({Key key, @required this.user}) : super(key: key);
  final user;
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
      body: StreamBuilder<List<Post>>(
        stream: DatabaseService(uid: widget.user.uid).individualPosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    posts[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(posts[index].content),
                  trailing: PopupMenuButton(
                    onSelected: (result) async {
                      final type = result['type'];
                      final post = result['value'];
                      switch (type) {
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPost(post: post),
                            ),
                          );
                          break;
                        case 'delete':
                          DatabaseService(uid: widget.user.uid)
                              .deletePost(post.id);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                          value: {'type': 'edit', 'value': posts[index]},
                          child: Text('Düzenle')),
                      PopupMenuItem(
                          value: {'type': 'delete', 'value': posts[index]},
                          child: Text('Sil')),
                    ],
                  ),
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
            );
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPost(),
              ),
            );
          },
          tooltip: 'Yeni Post',
          child: Icon(Icons.note_add)),
    );
  }
}
