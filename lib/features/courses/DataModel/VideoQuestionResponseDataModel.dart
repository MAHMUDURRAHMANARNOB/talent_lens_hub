class VideoQuestionResponseDataModel {
  final int errorCode;
  final String message;
  final String question;
  final String answer;
  final int commentId;

  VideoQuestionResponseDataModel({
    required this.errorCode,
    required this.message,
    required this.question,
    required this.answer,
    required this.commentId,
  });

  // Factory constructor to create an instance from JSON
  factory VideoQuestionResponseDataModel.fromJson(Map<String, dynamic> json) {
    return VideoQuestionResponseDataModel(
      errorCode: json['errorcode'],
      message: json['message'],
      question: json['question'],
      answer: json['answer'],
      commentId: json['commentid'],
    );
  }

  // Method to convert the instance back to JSON
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
