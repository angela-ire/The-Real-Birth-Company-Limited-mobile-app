class Bagitemmodel {
  String? item;
  bool? checked;

  Bagitemmodel({required this.item, required this.checked});

  static Bagitemmodel fromJson(Map<String, dynamic> json) => 
  Bagitemmodel(item: json['item'], checked: json['checked']);

    Map<String, dynamic> toJson() =>{
    'item' : item,
    'checked' : checked,
    };
}