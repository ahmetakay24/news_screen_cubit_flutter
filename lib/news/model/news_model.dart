import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class News {
  String? title;
  String? url;
  String? time_published;
  String? banner_image;

  News(this.title, this.url, this.time_published, this.banner_image);

  factory News.fromJson(dynamic json) {
    return News(
        json["title"] as String,
        json["url"] as String,
        json["time_published"] as String,
        json["banner_image"] != null
            ? json["banner_image"] as String
            : "https://cdn.pixabay.com/photo/2014/04/02/17/08/globe-308065_960_720.png");
  }

  @override
  String toString() {
    return "{$title,$url,$time_published,$banner_image";
  }
}
