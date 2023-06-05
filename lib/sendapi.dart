import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendData extends StatefulWidget {
  const SendData({Key? key}) : super(key: key);
  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  final TextEditingController _controller = TextEditingController();

////post
  Future<http.Response> createPost(String title) async {
    final data = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if(data.statusCode == 201){
      print("send ok "+ data.body);
    }else{
      print(data.statusCode);
    }
    return data;
  }

  //////del
  Future<http.Response> deletePost(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      print("del ok "+ response.body);
    }else{
      print(response.statusCode);
    }
    return response;
  }
  ///update
  Future<http.Response> updatePost(String title) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      print("update ok "+ response.body);
    } else {
      throw Exception('Failed to update album.');
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            // sendPost(_controller.text);
          }, child: Text("Ok"))
        ],
      )),
    );
  }
}
