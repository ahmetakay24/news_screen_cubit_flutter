import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class News {
  String? title;
  String? link;
  List<dynamic>? creator;
  String? description;
  String? pubDate;
  String? imageUrl;
  String? sourceIcon;

  News({this.title, this.link, this.creator, this.description, this.pubDate, this.imageUrl, this.sourceIcon});

  factory News.fromJson(dynamic json) {
    return News(
        title: json["title"] as String?,
        link: json["link"] as String?,
        creator: json["creator"] as List<dynamic>?,
        description: json["description"] as String?,
        pubDate: json["pubDate"] as String?,
        imageUrl: json["imageUrl"] as String?,
        sourceIcon: json["sourceIcon"] as String? ??
            "https://avatars.slack-edge.com/2020-04-21/1069616724710_52d32ecfe70c3c33b443_512.png");
  }

  @override
  String toString() {
    return "{$title,$link,$creator,$description,$pubDate,$imageUrl,$sourceIcon";
  }
}
