import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './model.dart';
import './dets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Post> _list = [];
  List<Post> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response = await http.get("http://10.0.2.2/miniblog/getdata.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Post.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.judul.toLowerCase().contains(text)) {
        _search.add(f);
      }
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.blue,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                controller: controller,
                onChanged: onSearch,
                decoration: InputDecoration(
                    hintText: "Cari Postingan", border: InputBorder.none),
              ),
              trailing: IconButton(
                onPressed: () {
                  controller.clear();
                  onSearch('');
                },
                icon: Icon(Icons.cancel),
              ),
            ),
          ),
        ),
        loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _search.length != 0 || controller.text.isNotEmpty
                    ? ListView.builder(
                        itemCount: _search.length,
                        itemBuilder: (context, i) {
                          final search = _search[i];
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            child: new GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Detail(
                                            list: [],
                                            index: i,
                                          ))),
                              child: new Card(
                                  child: new ListTile(
                                title: new Text(
                                  search.judul,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: Image.network(
                                  "http://10.0.2.2/miniblog/assets/img/post/" +
                                      search.file_gambar,
                                  height: 100,
                                  width: 100,
                                ),
                                subtitle: new Text(
                                    "Oleh : ${search.username}\nKategori : ${search.nama} \nDibaca ${search.read} kali"),
                                dense: true,
                              )),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, i) {
                          final a = _list[i];
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            child: new GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Detail(
                                            list: [],
                                            index: i,
                                          ))),
                              child: new Card(
                                  child: new ListTile(
                                title: new Text(
                                  a.judul,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: Image.network(
                                  "http://10.0.2.2/miniblog/assets/img/post/" +
                                      a.file_gambar,
                                  height: 100,
                                  width: 100,
                                ),
                                subtitle: new Text(
                                    "Oleh : ${a.username}\nKategori : ${a.nama} \nDibaca ${a.read} kali"),
                                dense: true,
                              )),
                            ),
                          );
                        }))
      ]),
    ));
  }
}
