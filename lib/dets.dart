import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<List> getKomen() async {
    final response = await http.get("http://10.0.2.2/miniblog/getkomen.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("${widget.list[widget.index]['judul']}")),
        body: Center(
          child: new Card(
            child: new ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Image.network("http://10.0.2.2/miniblog/assets/img/post/" +
                    widget.list[widget.index]['file_gambar']),
                new Padding(padding: const EdgeInsets.only(top: 10)),
                new Container(
                  child: Html(
                    data: widget.list[widget.index]['isi_post'],
                  ),
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    "Comments",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                new FutureBuilder<List>(
                  future: getKomen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new DetailKomen(
                            list: snapshot.data,
                            id: widget.list[widget.index]['idpost'])
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class DetailKomen extends StatelessWidget {
  final List list;
  final id;
  DetailKomen({this.list, this.id});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i]['idpost'] == id) {
          return Container(
            padding: const EdgeInsets.all(1),
            child: new Card(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: new ListTile(
                  title: new Text(list[i]['name']),
                  subtitle: new Text(list[i]['comment']),
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
