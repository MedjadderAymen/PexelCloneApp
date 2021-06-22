import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/Wallpaper.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.white70)),
        TextSpan(text: 'Hub', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
      ],
    ),
  );
}

Widget wallpapersList({List<Wallpaper> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          imageView(imgUrl: wallpaper.src.portrait)));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: new Container(
                child: ClipRRect(
                    borderRadius: new BorderRadius.circular(12),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ));
        }).toList()),
  );
}
