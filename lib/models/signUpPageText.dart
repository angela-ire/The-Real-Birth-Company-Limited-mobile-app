class Signuppagetext {

  String title;
  String nameBox;
  String passwordBox;
  String ageBox;
  String emailBox;
  String postcodeBox;
  String hospitalBox;
  String lnBox;
  String genderBox;
  String dueDateBox;
  String discoveryBox;
  String classesBox;

  String getTitle(){return title;}

  Signuppagetext({required this.title, required this.nameBox, required this.passwordBox, required this.ageBox,
  required this.emailBox, required this.postcodeBox, 
  required this.hospitalBox, required this.lnBox, required this.genderBox, required this.dueDateBox,
  required this.discoveryBox, required this.classesBox}){}

    /* Converts Firebase Json into class object */
  static Signuppagetext fromJson(Map<String, dynamic>? json) => 
  Signuppagetext(title: json?['title'], nameBox: json?['nameBox'], passwordBox: json?['passwordBox'], 
  ageBox: json?['ageBox'],  emailBox: json?['emailBox'], 
  postcodeBox: json?['postcodeBox'], lnBox: json?['lnBox'], genderBox: json?['genderBox'],
  dueDateBox: json?['dueDateBox'], hospitalBox: json?['hospitalBox'], discoveryBox: json?['discoveryBox'], 
  classesBox: json?['classesBox']);
}