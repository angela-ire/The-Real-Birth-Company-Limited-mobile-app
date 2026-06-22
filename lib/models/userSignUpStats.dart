// ignore_for_file: file_names

class Usersignupstats {
  int? totalUsers;
  int? en;
  int? ar;
  int? classes;
  /*Rough proof of concept age brackets*/
  int? underEighteen;
  int? eighteenTwentyFive;
  int? twentyFivePlus;

  int? discoveryOption1;
  int? discoveryOption2;

  Usersignupstats({required this.totalUsers, required this.en, required this.ar, required this.classes, 
  required this.underEighteen, required this.eighteenTwentyFive, required this.twentyFivePlus, 
  required this.discoveryOption1, required this.discoveryOption2}){}

    /* Converts Firebase Json into class object */
  static Usersignupstats fromJson(Map<String, dynamic>? json) => 
  Usersignupstats(totalUsers: json?['totalUsers'], en: json?['en'], ar: json?['ar'], 
  classes: json?['classes'], underEighteen: json?['underEighteen'], eighteenTwentyFive: json?['eighteenTwentyFive'], 
  twentyFivePlus: json?['twentyFivePlus'], discoveryOption1: json?['discoveryOption1'], discoveryOption2: json?['discoveryOption2']);
  

  Map<String, dynamic> toJson() =>{
    'totalUsers' : totalUsers,
    'en' : en,
    'ar' : ar,
    'classes' : classes,
    'underEighteen' : underEighteen,
    'eighteenTwentyFive' : eighteenTwentyFive,
    'twentyFivePlus' : twentyFivePlus,
    'discoveryOption1' : discoveryOption1,
    'discoveryOption2' : discoveryOption2,
  };

}