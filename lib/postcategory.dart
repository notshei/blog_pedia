import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './dets.dart';

// ignore: must_be_immutable
class PostCate extends StatefulWidget {
  List list;
  int index;
//  PostCate({this.list});
  PostCate({this.list, this.index});
  @override
  _PostCateState createState() => _PostCateState();
}

class _PostCateState extends State<PostCate> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/miniblog/getpostcate.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['nama']}"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                  id: widget.list[widget.index]['id'],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  final id;
  ItemList({this.list, this.id});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i]['idkategori'] == id) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      ))),
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    list[i]['judul'],
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: new Text(
                      "Oleh : ${list[i]['username']} \nDibaca ${list[i]['read']} kali"),
                  dense: true,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
