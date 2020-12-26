import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './dets.dart';

class Homey extends StatefulWidget {
  _HomeyState createState() => new _HomeyState();
}

class _HomeyState extends State<Homey> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/miniblog/getdata.php");
    return json.decode(response.body);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
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
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
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
                leading: Image.network(
                    "http://10.0.2.2/miniblog/assets/img/post/" +
                        list[i]['file_gambar']),
                subtitle: new Text(
                    "Oleh : ${list[i]['username']}\nKategori : ${list[i]['nama']} \nDibaca ${list[i]['read']} kali"),
                dense: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
