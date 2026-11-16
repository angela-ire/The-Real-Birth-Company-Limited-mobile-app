
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/quizController.dart';
import 'package:real_birth_app/models/quizModel.dart';

class Quizview extends StatefulWidget {
  final int quizNum;
  final String docName;

  const Quizview({super.key, required this.quizNum, required this.docName});

  @override
  State<Quizview> createState() => _Quizview();
}

class _Quizview extends State<Quizview>{
  final controller = Quizcontroller();
  int _currentIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  bool _isFinished = false;
  List<quizModel> _questions = [];

  @override
  void initState() {
    super.initState();
  }

  void _nextQuestion() {
    if (_selectedOptionIndex == _questions[_currentIndex].correctAnswerIndex) {
      _score++;
    }

    setState(() {
      if (_currentIndex < 4) {
        _currentIndex++;
        _selectedOptionIndex = null;
      } else {
        _isFinished = true;
      }
    });
  }

    void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _selectedOptionIndex = null;
      _score = 0;
      _isFinished = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Complete')),
        body: Center(
          child: StreamBuilder(stream: controller.fetchQuizs(widget.docName), builder: (controller, snapshot){
            if(snapshot.hasData){
              _questions = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Score: $_score / ${_questions.length}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _restartQuiz,
                  child: const Text('Restart Quiz'),
                ),],
              );
            }
            return Text("");
          }),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1} of ${_questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(stream: controller.fetchQuizs(widget.docName), builder: (controller, snapshot) {
          if(snapshot.hasData){
            _questions = snapshot.data!;
            final currentQuestion = _questions[_currentIndex];
            return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.question,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ...List.generate(currentQuestion.questions.length, (index) {
                return Card(
                  child: RadioListTile<int>(
                    title: Text(currentQuestion.questions[index]),
                    value: index,
                    groupValue: _selectedOptionIndex,
                    onChanged: (value) {
                      setState(() {
                        _selectedOptionIndex = value;
                      });
                    },
                  ),
                );
              }),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOptionIndex == null ? null : _nextQuestion,
              child: Text(
                _currentIndex == _questions.length - 1 ? 'Finish' : 'Next',
              ),
            ),
          ],
        );
          }
        return Text("");
        }
      ),
    ));
  }
}
