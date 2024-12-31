class CoverLetterResponseDataModel {
  final int errorCode;
  final String message;
  final String coverLetter;

  CoverLetterResponseDataModel({
    required this.errorCode,
    required this.message,
    required this.coverLetter,
  });

  // Factory method to create an instance from a JSON map
  factory CoverLetterResponseDataModel.fromJson(Map<String, dynamic> json) {
    return CoverLetterResponseDataModel(
      errorCode: json['errorcode'],
      message: json['message'],
      coverLetter: json['coverletter'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'errorcode': errorCode,
      'message': message,
      'coverletter': coverLetter,
    };
  }
}
