import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/Wallpaper.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();
  List<Wallpaper> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=15&page=1",
        headers: {"Authorization": myApiKey});

    print(response.body.toString());

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
    getTrendingWallpapers();
    categories = getCategories();
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
                height: 16,
              ),
              Container(
                decoration: new BoxDecoration(
                    color: Colors.white70,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => search(
                                        searchQuery: searchController.text,
                                      )));
                        },
                        child: Container(child: new Icon(Icons.search)))
                  ],
                ),
              ),
              new SizedBox(
                height: 16,
              ),
              new Container(
                height: 50,
                child: new ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
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

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;

  CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                      category: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: new Stack(
          children: [
            ClipRRect(
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.circular(8),
            ),
            ClipRRect(
              borderRadius: new BorderRadius.circular(8),
              child: new Container(
                color: Colors.black12,
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: new Text(
                  title,
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
