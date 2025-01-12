class CourseExamModel {
  final int? errorCode;
  final String? message;
  final int? examPaperId;
  final int? questionId;
  final String? questionText;
  final List<Answer>? answers;

  CourseExamModel({
    this.errorCode,
    this.message,
    this.examPaperId,
    this.questionId,
    this.questionText,
    this.answers,
  });

  factory CourseExamModel.fromJson(Map<String, dynamic> json) {
    return CourseExamModel(
      errorCode: json['errorcode'],
      message: json['message'],
      examPaperId: json['examPaperId'],
      questionId: json['questionID'],
      questionText: json['QueText'],
      answers: (json['ansList'] as List<dynamic>)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }
}

class Answer {
  final int id;
  final String text;

  Answer({
    required this.id,
    required this.text,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['ansText'],
    );
  }
}
