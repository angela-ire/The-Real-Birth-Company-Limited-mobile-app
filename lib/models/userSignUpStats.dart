// ignore_for_file: file_names

class Usersignupstats {
  int totalUsers = 0;
  int en = 0;
  int ar = 0;
  int classes = 0;
  /*Rough proof of concept age brackets*/
  int underEighteen = 0;
  int eighteenTwentyFive = 0;
  int twentyFivePlus = 0;

  int female = 0;
  int male = 0;

  int? discoveryOption1;
  int? discoveryOption2;

  Usersignupstats({required this.totalUsers, required this.en, required this.ar, required this.classes, 
  required this.underEighteen, required this.eighteenTwentyFive, required this.twentyFivePlus, 
  required this.discoveryOption1, required this.discoveryOption2, required this.female, required this.male}){}

    /* Converts Firebase Json into class object */
  static Usersignupstats fromJson(Map<String, dynamic>? json) => 
  Usersignupstats(totalUsers: json?['totalUsers'], en: json?['en'], ar: json?['ar'], 
  classes: json?['classes'], underEighteen: json?['underEighteen'], eighteenTwentyFive: json?['eighteenTwentyFive'], 
  twentyFivePlus: json?['twentyFivePlus'], discoveryOption1: json?['discoveryOption1'], discoveryOption2: json?['discoveryOption2'], 
  female: json?['female'], male: json?['male']);
  

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
    'male' : male,
    'female' : female
  };

}