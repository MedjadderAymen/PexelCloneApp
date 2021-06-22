import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/Wallpaper.dart';
import 'package:wallpaper_app/widgets/widget.dart';

class Category extends StatefulWidget {
  final String category;

  Category({this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
    getSearchWallpapers(widget.category);
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
