import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class imageView extends StatefulWidget {
  final String imgUrl;

  imageView({@required this.imgUrl});

  @override
  _imageViewState createState() => _imageViewState();
}

class _imageViewState extends State<imageView> {
  var imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff1C1B1B).withOpacity(0.8)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        decoration: new BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ])),
                        child: Column(
                          children: [
                            Text(
                              "set Image Wallpaper",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            Text(
                              "image will be saved in gallery",
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 50.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

/*  _save() async {
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }*/

  _save() async {
    await _askPermission();
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage,PermissionGroup.unknown,PermissionGroup.photos]);
    /* PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);*/
  }
}
