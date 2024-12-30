class InterviewQuestionsResponseDataModel {
  final int errorCode;
  final String message;
  final List<InterviewQuestion> interviewQuestions;

  InterviewQuestionsResponseDataModel({
    required this.errorCode,
    required this.message,
    required this.interviewQuestions,
  });

  factory InterviewQuestionsResponseDataModel.fromJson(
      Map<String, dynamic> json) {
    return InterviewQuestionsResponseDataModel(
      errorCode: json['errorcode'] ?? 0,
      message: json['message'] ?? '',
      interviewQuestions: (json['interviewQuestions'] as List<dynamic>?)
              ?.map((e) => InterviewQuestion.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errorcode': errorCode,
      'message': message,
      'interviewQuestions': interviewQuestions.map((e) => e.toJson()).toList(),
    };
  }
}

class InterviewQuestion {
  final String question;
  final String answer;

  InterviewQuestion({
    required this.question,
    required this.answer,
  });

  factory InterviewQuestion.fromJson(Map<String, dynamic> json) {
    return InterviewQuestion(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
