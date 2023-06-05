import 'dart:convert';

import 'package:demo_resetapi/model/post.dart';
import 'package:demo_resetapi/sendapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SendData(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Post> postList;
  List<Post> listPost = [];

  void getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final data = await http.get(url);
    if (data.statusCode == 200) {
      final jsonData = jsonDecode(data.body);
      List<Post> posts = [];
      for (var json in jsonData) {
        Post post = Post.fromJson(json);
        posts.add(post);
      }
      listPost = posts;
      setState(() {});
    } else {
      print(data.statusCode);
    }
  }

  Future<Post> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final data = await http.get(url);
    return Post.fromJson(json.decode(data.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postList = fetchPosts();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          // ElevatedButton(
          //     onPressed: () {
          //       setState(() {
          //         postList = fetchPosts();
          //       });
          //     },
          //     child: const Text("Get data")),
          // FutureBuilder<Post>(
          //   future: postList,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Text("${snapshot.data?.body}");
          //     } else if (snapshot.hasError) {
          //       return Text("${snapshot.error}");
          //     }
          //     return const CircularProgressIndicator();
          //   },
          // ),
          ListView.builder(
            itemCount: listPost.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text("${listPost[index].title}"),
                  subtitle: Text("${listPost[index].body}"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
