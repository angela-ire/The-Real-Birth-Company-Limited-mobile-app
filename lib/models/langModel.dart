// ignore_for_file: file_names

class Langmodel {
  String key;
  String text;

Langmodel({required this.key, required this.text}){}

  /* Converts Firebase Json into class object */
  static Langmodel fromJson(Map<String, dynamic> json) => Langmodel(key: json['key'], text: json['text']);
}