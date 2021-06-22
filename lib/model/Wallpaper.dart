class Wallpaper {
  String photographer, photographer_url;
  int photographer_id;
  Src src;

  Wallpaper(
      {this.src,
      this.photographer,
      this.photographer_url,
      this.photographer_id});

  factory Wallpaper.fromMap(Map<String, dynamic> jsonData) {
    return Wallpaper(
      src: Src.fromMap(jsonData["src"]),
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
      photographer_url: jsonData['photographer_url'],
    );
  }
}

class Src {
  String original;
  String small;
  String portrait;

  Src({this.original, this.small, this.portrait});

  factory Src.fromMap(Map<String, dynamic> jsonData) {
    return Src(
      original: jsonData["original"],
      small: jsonData['small'],
      portrait: jsonData['portrait'],
    );
  }
}
