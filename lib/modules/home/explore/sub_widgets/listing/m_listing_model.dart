// To parse this JSON data, do
//
//     final dummyPlaces = dummyPlacesFromJson(jsonString);

import 'dart:convert';

DummyPlaces dummyPlacesFromJson(String str) =>
    DummyPlaces.fromJson(json.decode(str));

String dummyPlacesToJson(DummyPlaces data) => json.encode(data.toJson());

class DummyPlaces {
  List<String> images;
  bool popular;
  bool isFav;
  String name;
  String type;
  String date;
  String price;
  String rating;
  String review;
  String otherInfo;
  String about;

  DummyPlaces({
    required this.images,
    required this.popular,
    required this.isFav,
    required this.name,
    required this.type,
    required this.date,
    required this.price,
    required this.rating,
    required this.review,
    required this.otherInfo,
    required this.about,
  });

  factory DummyPlaces.fromJson(Map<String, dynamic> json) => DummyPlaces(
        images: List<String>.from(json["images"].map((x) => x)),
        popular: json["popular"],
        isFav: json["isFav"],
        name: json["name"],
        type: json["type"],
        date: json["date"],
        price: json["price"],
        rating: json["rating"],
        review: json["review"],
        otherInfo: json["other info"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "popular": popular,
        "isFav": isFav,
        "name": name,
        "type": type,
        "date": date,
        "price": price,
        "rating": rating,
        "review": review,
        "other info": otherInfo,
        "about": about,
      };
}
