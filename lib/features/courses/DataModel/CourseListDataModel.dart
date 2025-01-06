class CourseListDataModel {
  final int id;
  final int totalStudents;
  final String courseName;
  final String courseDescription;
  final String? imgPath;
  final int defaultCategory;

  CourseListDataModel({
    required this.id,
    required this.totalStudents,
    required this.courseName,
    required this.courseDescription,
    this.imgPath,
    required this.defaultCategory,
  });

  factory CourseListDataModel.fromJson(Map<String, dynamic> json) {
    return CourseListDataModel(
      id: json['id'],
      totalStudents: json['TotalStudents'],
      courseName: json['CourseName'],
      courseDescription: json['CourseDescription'],
      imgPath: json['ImgPath'],
      defaultCategory: json['DefaultCategory'],
    );
  }
}
