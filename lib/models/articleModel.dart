import 'dart:core';

class Articlemodel {
  String key;
  String link;
  String name;

Articlemodel({required this.key, required this.link, required this.name}){}

  /* Converts Firebase Json into class object */
  static Articlemodel fromJson(Map<String, dynamic> json) => Articlemodel(key: json['key'], link: json['link'], name: json['name']);
}