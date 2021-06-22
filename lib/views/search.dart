import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/Wallpaper.dart';
import 'package:wallpaper_app/widgets/widget.dart';

class search extends StatefulWidget {
  final String searchQuery;

  search({this.searchQuery});

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController searchController = new TextEditingController();
  List<Wallpaper> wallpapers = new List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {"Authorization": myApiKey});

    print(response.body.toString());

    wallpapers.removeRange(0, wallpapers.length);

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      Wallpaper wallpaper = new Wallpaper();
      wallpaper = Wallpaper.fromMap(element);
      wallpapers.add(wallpaper);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpapers(widget.searchQuery);
    searchController.text=widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: brandName(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: new Container(
          color: Colors.black87,
          child: new Column(
            children: [
              new SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: new BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: new BorderRadius.circular(25)),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: new Row(
                  children: [
                    new Expanded(
                      child: new TextField(
                        decoration: new InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none),
                        controller: searchController,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          getSearchWallpapers(searchController.text);
                        },
                        child: Container(child: new Icon(Icons.search)))
                  ],
                ),
              ),
              new SizedBox(
                height: 16.0,
              ),
              wallpapersList(wallpapers: wallpapers, context: context),
              new SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
