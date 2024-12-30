class ToolsResponseDataModel {
  final int? errorCode;
  final String? message;
  final String? answer;

  ToolsResponseDataModel({
    required this.errorCode,
    required this.message,
    required this.answer,
  });

  factory ToolsResponseDataModel.fromJson(Map<String, dynamic> json) {
    return ToolsResponseDataModel(
      errorCode: json['errorcode'],
      message: json['message'],
      answer: json['answer'],
    );
  }
}
