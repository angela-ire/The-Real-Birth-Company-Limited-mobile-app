
class quizModel {

  String question;
  List<String> questions;
  int correctAnswerIndex;
  String reason;

  quizModel({required this.question, required this.questions, required this.correctAnswerIndex, required this.reason});

  static quizModel fromJson(Map<String, dynamic>? json) => 
   quizModel(question: json?['question'], questions: List.from(json?['questions']),correctAnswerIndex: json?['correctAnswerIndex'], reason: json?['reason']);

}