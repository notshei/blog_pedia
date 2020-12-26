import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './home.dart' as ho;
import './category.dart' as cate;
import './search.dart' as sea;

void main() {
  runApp(new MaterialApp(
    title: "BlogPedia",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/miniblog/getdata.php");
    return json.decode(response.body);
  }

  TabController controller;

  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("BlogPedia"),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new ho.Homey(),
          new cate.Category(),
          new sea.Search(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.home),
              text: "Home",
            ),
            new Tab(icon: new Icon(Icons.category), text: "Category"),
            new Tab(
              icon: new Icon(Icons.search),
              text: "Search",
            )
          ],
        ),
      ),
    );
  }
}
