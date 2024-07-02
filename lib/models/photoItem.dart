class photoItem {
  final int albumId;
  final int id;
  final String title;
  final String imageUrl;
  final String thumbnailImageUrl;

  //costruttore
  photoItem(
      this.albumId, this.id, this.title, this.imageUrl, this.thumbnailImageUrl);

  //costruttore json
  photoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        albumId = json['albumId'],
        title = json['title'],
        imageUrl = json['url'],
        thumbnailImageUrl = json['thumbnailUrl'];
}

//coso nuovo che non va un cazzo
/*

import 'package:json_annotation/json_annotation.dart';

part 'photoItem.g.dart';

@JsonSerializable()
class photoItem {
  @JsonKey(defaultValue: -1)
  final int albumId;

  @JsonKey(required: true)
  final int id;

  final String title;

  @JsonKey(name: "url")
  final String imageUrl;

  @JsonKey(name: "t_url")
  final String thumbnailImageUrl;

  //costruttore
  photoItem(
      this.albumId, this.id, this.title, this.imageUrl, this.thumbnailImageUrl);

  //factory = costruttore che non costruisce veramente gli oggetti ma li fa costruire a qualun'altro
  factory photoItem.fromJson(Map<String, dynamic> json) =>
      _$photoItemFromJson(json);

  Map<String, dynamic> toJson() => _$photoItemToJson(this);
  //costruttore json
  /*photoItem.fromJson(Map<String, dynamic> json):
    id = json['id'],
    albumId = json['albumId'],
    title = json['title'],
    imageUrl = json['url'],
    thumbnailImageUrl = json['thumbnailUrl'];*/
}


*/ 