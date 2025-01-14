class RecommendedCoursesDataModel {
  final int? errorCode;
  final String? message;
  final List<Course>? courses;

  RecommendedCoursesDataModel({this.errorCode, this.message, this.courses});

  // Factory method to parse the API response
  factory RecommendedCoursesDataModel.fromJson(dynamic json) {
    // Case 1: If the response is a list, parse it as a list of courses
    if (json is List) {
      return RecommendedCoursesDataModel(
        courses: json.map((course) => Course.fromJson(course)).toList(),
      );
    }

    // Case 2: If the response is a map, handle it based on errorCode or courses key
    if (json is Map<String, dynamic>) {
      if (json.containsKey('errorcode')) {
        // Error scenario
        return RecommendedCoursesDataModel(
          errorCode: json['errorcode'],
          message: json['message'],
        );
      } else if (json.containsKey('courses')) {
        // Success scenario with 'courses' key
        var coursesJson = json['courses'] as List<dynamic>;
        return RecommendedCoursesDataModel(
          courses:
              coursesJson.map((course) => Course.fromJson(course)).toList(),
        );
      }
    }

    throw Exception('Unexpected API response format');
  }
}

class Course {
  final int courseID;
  final String title;
  final double relevanceScore;

  Course({
    required this.courseID,
    required this.title,
    required this.relevanceScore,
  });

  // Factory method to parse a course object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseID: json['CourseID'],
      title: json['Title'],
      relevanceScore: (json['RelevanceScore'] as num).toDouble(),
    );
  }
}
