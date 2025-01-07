class CheckEnrollmentDataModel {
  final int? id;
  final int? userId;
  final int? courseId;
  final int? lessonCount;
  final String? lastAccessDate;
  final String? isExamTaken;
  final int? examScore;
  final String? certificateFile;
  final String? examReport;
  final String? isExamStarted;
  final int? examAttempt;
  final String? userCertificateName;
  final String? uniqueCode;

  CheckEnrollmentDataModel({
    this.id,
    this.userId,
    this.courseId,
    this.lessonCount,
    this.lastAccessDate,
    this.isExamTaken,
    this.examScore,
    this.certificateFile,
    this.examReport,
    this.isExamStarted,
    this.examAttempt,
    this.userCertificateName,
    this.uniqueCode,
  });

  factory CheckEnrollmentDataModel.fromJson(Map<String, dynamic> json) {
    return CheckEnrollmentDataModel(
      id: json['id'],
      userId: json['UserId'],
      courseId: json['CourseID'],
      lessonCount: json['Lessoncount'],
      lastAccessDate: json['lastaccessdate'],
      isExamTaken: json['isExamTaken'],
      examScore: json['ExamScore'],
      certificateFile: json['certificateFile'],
      examReport: json['examReport'],
      isExamStarted: json['isExamStarted'],
      examAttempt: json['examAttempt'],
      userCertificateName: json['userCertificateName'],
      uniqueCode: json['uniqueCode'],
    );
  }
}
