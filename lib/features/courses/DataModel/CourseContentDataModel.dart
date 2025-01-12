import 'dart:convert';

class CourseResponseModel {
  final List<CourseDataModel> coursedata;
  final List<LessonDataModel> lessondata;

  CourseResponseModel({
    required this.coursedata,
    required this.lessondata,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      coursedata: (json['coursedata'] as List)
          .map((course) => CourseDataModel.fromJson(course))
          .toList(),
      lessondata: (json['lessondata'] as List)
          .map((lesson) => LessonDataModel.fromJson(lesson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coursedata': coursedata.map((course) => course.toJson()).toList(),
      'lessondata': lessondata.map((lesson) => lesson.toJson()).toList(),
    };
  }
}

class CourseDataModel {
  final int id;
  final String courseName;
  final String courseDescription;
  final int defaultCategory;
  final String? startDate;
  final List<String> tagText;
  final String gradeClass;
  final String subjectName;
  final String? createDate;
  final int lessonCount;
  final int? enrolled;
  final bool? isActive;
  final String? imgPath;
  final bool isMath;
  final String duration;
  final String prerequisites;
  final List<String> targetAudience;
  final bool isContentDone;
  final String isCertificateAvailable;
  final bool isBangla;
  final int totalStudents;
  final String difficultyLevel;
  final String examNoOfQuestions;
  final bool isExamAvailable;

  CourseDataModel({
    required this.id,
    required this.courseName,
    required this.courseDescription,
    required this.defaultCategory,
    this.startDate,
    required this.tagText,
    required this.gradeClass,
    required this.subjectName,
    this.createDate,
    required this.lessonCount,
    this.enrolled,
    this.isActive,
    this.imgPath,
    required this.isMath,
    required this.duration,
    required this.prerequisites,
    required this.targetAudience,
    required this.isContentDone,
    required this.isCertificateAvailable,
    required this.isBangla,
    required this.totalStudents,
    required this.difficultyLevel,
    required this.examNoOfQuestions,
    required this.isExamAvailable,
  });

  factory CourseDataModel.fromJson(Map<String, dynamic> json) {
    // Helper function to parse tagtext and targetAudience
    List<String> parseStringList(dynamic field) {
      if (field is String) {
        try {
          return (jsonDecode(field) as List<dynamic>).cast<String>();
        } catch (e) {
          print('Error parsing string to list: $e');
          return [];
        }
      } else if (field is List) {
        return field.cast<String>();
      } else {
        return [];
      }
    }

    return CourseDataModel(
      id: json['id'],
      courseName: json['CourseName'],
      courseDescription: json['CourseDescription'],
      defaultCategory: json['DefaultCategory'],
      startDate: json['StartDate'],
      tagText: parseStringList(json['tagtext']),
      gradeClass: json['gradeclass'],
      subjectName: json['Subject_name'],
      createDate: json['CreateDate'],
      lessonCount: json['Lessoncount'],
      enrolled: json['Enrolled'],
      isActive: json['isactive'] == "Y",
      imgPath: json['ImgPath'],
      isMath: json['isMath'] == "Y",
      duration: json['duration'].toString(),
      // Convert to String
      prerequisites: json['prerequisites'],
      targetAudience: parseStringList(json['targetAudience']),
      isContentDone: json['iscontentdone'] == "Y",
      isCertificateAvailable: json['isCertificateAvailable'],
      isBangla: json['isBangla'] == "Y",
      totalStudents: json['TotalStudents'],
      difficultyLevel: json['difficultilevel'],
      examNoOfQuestions: json['ExamNoOfQuestions'].toString(),
      isExamAvailable: json['IsExamAvailable'] == "Y",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CourseName': courseName,
      'CourseDescription': courseDescription,
      'DefaultCategory': defaultCategory,
      'StartDate': startDate,
      'tagtext': tagText,
      'gradeclass': gradeClass,
      'Subject_name': subjectName,
      'CreateDate': createDate,
      'Lessoncount': lessonCount,
      'Enrolled': enrolled,
      'isactive': isActive == true ? "Y" : "N",
      'ImgPath': imgPath,
      'isMath': isMath ? "Y" : "N",
      'duration': duration,
      'prerequisites': prerequisites,
      'targetAudience': targetAudience,
      'iscontentdone': isContentDone ? "Y" : "N",
      'isCertificateAvailable': isCertificateAvailable,
      'isBangla': isBangla ? "Y" : "N",
      'TotalStudents': totalStudents,
      'difficultilevel': difficultyLevel,
      'ExamNoOfQuestions': examNoOfQuestions,
      'IsExamAvailable': isExamAvailable ? "Y" : "N",
    };
  }
}

class LessonDataModel {
  final int id;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int answerCount;
  final int seqNo;
  final String isActive;
  final int chapterIndex;
  final String isProcessed;
  final String isAssignment;
  final String isFree;

  LessonDataModel({
    required this.id,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.answerCount,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
    required this.isProcessed,
    required this.isAssignment,
    required this.isFree,
  });

  factory LessonDataModel.fromJson(Map<String, dynamic> json) {
    return LessonDataModel(
      id: json['id'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      answerCount: json['Anscount'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
      isProcessed: json['isProcessed'],
      isAssignment: json['isassigment'],
      isFree: json['isFree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Courseid': courseId,
      'Lessontitle': lessonTitle,
      'isChapter': isChapter,
      'Anscount': answerCount,
      'SeqNo': seqNo,
      'isactive': isActive,
      'chapterIndex': chapterIndex,
      'isProcessed': isProcessed,
      'isassigment': isAssignment,
      'isFree': isFree,
    };
  }
}
