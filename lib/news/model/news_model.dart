import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class News {
  String? title;
  String? link;
  List<String>? creator;
  String? description;
  String? pubDate;
  String? imageUrl;
  String? sourceIcon;

  News({this.title, this.link, this.creator, this.description, this.pubDate, this.imageUrl, this.sourceIcon});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    creator = json['creator'].cast<String>();
    description = json['description'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceIcon = json['source_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['creator'] = creator;
    data['description'] = description;
    data['pubDate'] = pubDate;
    data['image_url'] = imageUrl;
    data['source_icon'] = sourceIcon;
    return data;
  }
}
