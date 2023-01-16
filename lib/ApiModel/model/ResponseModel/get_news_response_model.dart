// To parse this JSON data, do
//
//     final getNewsResponseModel = getNewsResponseModelFromJson(jsonString);

import 'dart:convert';

GetNewsResponseModel getNewsResponseModelFromJson(String str) =>
    GetNewsResponseModel.fromJson(json.decode(str));

String getNewsResponseModelToJson(GetNewsResponseModel data) =>
    json.encode(data.toJson());

class GetNewsResponseModel {
  GetNewsResponseModel({
    this.category,
    this.data,
    this.success,
  });

  String? category;
  List<Datum>? data;
  bool? success;

  factory GetNewsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetNewsResponseModel(
        category: json["category"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class Datum {
  Datum({
    this.author,
    this.content,
    this.date,
    this.id,
    this.imageUrl,
    this.readMoreUrl,
    this.time,
    this.title,
    this.url,
  });

  String? author;
  String? content;
  Date? date;
  String? id;
  String? imageUrl;
  String? readMoreUrl;
  String? time;
  String? title;
  String? url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        author: json["author"],
        content: json["content"],
        date: dateValues.map[json["date"]],
        id: json["id"],
        imageUrl: json["imageUrl"],
        readMoreUrl: json["readMoreUrl"] == null ? null : json["readMoreUrl"],
        time: json["time"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "date": dateValues.reverse![date],
        "id": id,
        "imageUrl": imageUrl,
        "readMoreUrl": readMoreUrl == null ? null : readMoreUrl,
        "time": time,
        "title": title,
        "url": url,
      };
}

enum Date { THE_15_NOV_2022_TUESDAY }

final dateValues =
    EnumValues({"15 Nov 2022,Tuesday": Date.THE_15_NOV_2022_TUESDAY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
