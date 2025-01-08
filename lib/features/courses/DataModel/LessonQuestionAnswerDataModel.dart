class LessonQuestionAnswerDataModel {
  final int? errorCode;
  final String? message;
  final String? question;
  final String? answer;
  final int? commentId;

  LessonQuestionAnswerDataModel({
    required this.errorCode,
    required this.message,
    required this.question,
    required this.answer,
    required this.commentId,
  });

  // Factory method to create an instance from JSON
  factory LessonQuestionAnswerDataModel.fromJson(Map<String, dynamic> json) {
    return LessonQuestionAnswerDataModel(
      errorCode: json['errorcode'],
      message: json['message'],
      question: json['question'],
      answer: json['answer'],
      commentId: json['commentid'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'errorcode': errorCode,
      'message': message,
      'question': question,
      'answer': answer,
      'commentid': commentId,
    };
  }
}
