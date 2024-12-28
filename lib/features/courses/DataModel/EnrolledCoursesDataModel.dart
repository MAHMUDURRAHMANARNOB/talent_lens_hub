class EnrolledCoursesDataModel {
  final int id;
  final String courseName;
  final String courseDescription;
  final String? imgPath;
  final int defaultCategory;
  final int lessonCount;
  final DateTime lastAccessDate;
  final String isExamTaken;
  final int? examScore;
  final String? certificateFile;

  EnrolledCoursesDataModel({
    required this.id,
    required this.courseName,
    required this.courseDescription,
    this.imgPath,
    required this.defaultCategory,
    required this.lessonCount,
    required this.lastAccessDate,
    required this.isExamTaken,
    this.examScore,
    this.certificateFile,
  });

  // Factory method to parse JSON into a Course object
  factory EnrolledCoursesDataModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCoursesDataModel(
      id: json['id'],
      courseName: json['CourseName'],
      courseDescription: json['CourseDescription'],
      imgPath: json['ImgPath'],
      defaultCategory: json['DefaultCategory'],
      lessonCount: json['Lessoncount'],
      lastAccessDate: DateTime.parse(json['lastaccessdate']),
      isExamTaken: json['isExamTaken'],
      examScore: json['ExamScore'],
      certificateFile: json['certificateFile'],
    );
  }

  // Convert a Course object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CourseName': courseName,
      'CourseDescription': courseDescription,
      'ImgPath': imgPath,
      'DefaultCategory': defaultCategory,
      'Lessoncount': lessonCount,
      'lastaccessdate': lastAccessDate.toIso8601String(),
      'isExamTaken': isExamTaken,
      'ExamScore': examScore,
      'certificateFile': certificateFile,
    };
  }
}
