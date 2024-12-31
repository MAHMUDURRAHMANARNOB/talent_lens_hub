import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:talent_lens_hub/features/courses/DataModel/CourseListDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/EnrolledCoursesDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonVideosDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/TrainingCategoryDataModel.dart';

import '../features/ToolsContent/datamodel/studyToolsDataModel.dart';
import '../features/courses/DataModel/CourseContentDataModel.dart';
import '../features/courses/DataModel/VideoQuestionResponseDataModel.dart';

class ApiController {
  static const String baseUrl = 'https://testapi.talentlenshub.com';

  static const String webURL = 'https://demoapi.talentlenshub.com/api';

  Future<List<TrainingCategoryDataModel>> getTrainingCategories() async {
    try {
      final response = await http.get(Uri.parse("$webURL/training/categories"));

      if (response.statusCode == 200) {
        var responseBody = response.body;
        // Decode the response body into a List<dynamic> and map it to a list of TrainingCategoryDataModel
        List<dynamic> data = json.decode(responseBody);
        // print(data);
        return data
            .map((json) => TrainingCategoryDataModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load training categories');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Method to fetch courseList by category
  Future<List<CourseListDataModel>> getCoursesByCategory(
      int? courseCategoryId) async {
    final response = await http
        .get(Uri.parse('$webURL/training/getcoursesbyid/$courseCategoryId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((course) => CourseListDataModel.fromJson(course))
          .toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Method to fetch courses Content by course ID
  Future<Map<String, dynamic>> getCoursesContent(int? courseCategoryId) async {
    try {
      // print(
      //     'Fetching courses from: $webURL/training/training_details/$courseCategoryId');
      final response = await http.get(
          Uri.parse('$webURL/training/training_details/$courseCategoryId'));

      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch courses');
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception('Failed to fetch courses: $e');
    }
  }

  // Method to fetch lesson content by course-lesson Id
  Future<List<dynamic>> fetchLessonAnswer(int lessonId) async {
    final url = Uri.parse('$webURL/training/training_lessonanswer/$lessonId');
    // print(url);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          // print("json response ${json.decode(response.body)}");
          return json.decode(response.body);
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load lesson answer: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lesson answer: $e');
    }
  }

  // to fetch lesson videos by course-lesson ID
  Future<List<LessonVideosDataModel>> fetchLessonVideos(int lessonId) async {
    final url = Uri.parse('$webURL/training/training_lessonvideo/$lessonId');
    // print(url);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // print("json response ${json.decode(response.body)}");
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((json) => LessonVideosDataModel.fromJson(json))
            .toList();

        // return json.decode(response.body);
      } else {
        throw Exception('Failed to load lesson videos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lesson answer: $e');
    }
  }

  // fetch lesson answer
  Future<Map<String, dynamic>> fetchVideoAnswer({
    required String question,
    required int videoID,
    required int userId,
  }) async {
    try {
      /*const uri = "${baseUrl}/videoanswer/";
      final Map<String, String> body = {
        'question': question,
        'videoID': videoID.toString(),
        'userid': userId.toString(),
      };*/
      final uri = Uri.parse("$baseUrl/videoanswer/").replace(queryParameters: {
        'question': question,
        'videoID': videoID.toString(),
        'userid': userId.toString(),
      });

      final response = await http.post(
        /*Uri.parse(uri),
        body: body,*/
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Indicate form-data
        },
        // Ensure headers match backend expectations
        // body: body,
      );
      // print("Request Body: $body");

      if (response.statusCode == 200) {
        final responseBody = Utf8Decoder().convert(response.bodyBytes);
        print("responsebody: $responseBody");
        final jsonResponse = jsonDecode(response.body);
        print("jsonResponse: hi$jsonResponse");
        var finalResponse = Utf8Decoder().convert(response.bodyBytes);
        return json.decode(responseBody);
      } else {
        print("Error Status Code: ${response.statusCode}");

        // print("Request Body: $body");
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Enrolled Courses
  Future<List<EnrolledCoursesDataModel>> fetchEnrolledCourses(
      String userId) async {
    try {
      final response = await http
          .get(Uri.parse("$webURL/training/get_enroll_courses/$userId"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data
            .map((course) => EnrolledCoursesDataModel.fromJson(course))
            .toList();
      } else {
        throw Exception(
            "Failed to fetch courses. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching courses: $e");
    }
  }

  // Recommend Jobs by Interest (user_interest)

  // Recommend jobs + Training for Job Description (job desc)

  // Redeem Gift Code (UserID, GiftCode)

  // RISHO SPEECH

  /*Tools Response*/
  Future<Map<String, dynamic>> getMathSolutionResponse(
    int userid,
    String problemText,
  ) async {
    final url = '$baseUrl/SolvebanglaMath/';
    print("Posting in api service $url, $userid, $problemText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'questiontext': problemText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getMathSolutionResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getMathSolutionResponse');
      }
    } catch (e) {
      throw Exception("Failed getMathSolutionResponse $e");
    }
  }

  Future<Map<String, dynamic>> getCareerCounselorResponse(
    int userid,
    String problemText,
    String skillText,
    String interstTopic,
    String experinceText,
  ) async {
    final url = '$baseUrl/careercounselor';
    print(
        "Posting in api service $url, $userid, $problemText, $skillText, $interstTopic, $experinceText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'problemText': problemText.toString(),
          'skillText': skillText.toString(),
          'interstTopic': interstTopic.toString(),
          'experinceText': experinceText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsResponse');
      }
    } catch (e) {
      throw Exception("Failed getToolsResponse $e");
    }
  }

  Future<Map<String, dynamic>> getLifeCoachResponse(
    int userid,
    String problemText,
  ) async {
    final url = '$baseUrl/lifecoach';
    print("Posting in api service $url, $userid, $problemText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'problemText': problemText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsResponse');
      }
    } catch (e) {
      throw Exception("Failed getToolsResponse $e");
    }
  }

  Future<Map<String, dynamic>> getMentalHealthResponse(
    int userid,
    String problemText,
  ) async {
    final url = '$baseUrl/mentalhealth';
    print("Posting in api service $url, $userid, $problemText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'problemText': problemText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsResponse');
      }
    } catch (e) {
      throw Exception("Failed getToolsResponse $e");
    }
  }

  Future<Map<String, dynamic>> getRelationshipCoachResponse(
    int userid,
    String problemText,
  ) async {
    final url = '$baseUrl/relationshipcoach';
    print("Posting in api service $url, $userid, $problemText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'problemText': problemText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getRelationshipCoachResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getRelationshipCoachResponse');
      }
    } catch (e) {
      throw Exception("Failed getRelationshipCoachResponse $e");
    }
  }

  Future<Map<String, dynamic>> getPsychologyResponse(
    int userid,
    String problemText,
  ) async {
    final url = '$baseUrl/psychologist';
    print("Posting in api service $url, $userid, $problemText");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'problemText': problemText.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getPsychologyResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getPsychologyResponse');
      }
    } catch (e) {
      throw Exception("Failed getPsychologyResponse $e");
    }
  }

  // Interview Question response
  Future<Map<String, dynamic>> getInterviewQuestionResponse(
    int userId,
    String jobTitle,
    String jobDescription,
    String noOfQuestions,
  ) async {
    final url = '$baseUrl/interviewQuestions';
    print(
        "Posting in api service $url, $userId, $jobTitle, $jobDescription, $noOfQuestions");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userId.toString(),
          'jobtitle': jobTitle.toString(),
          'jobtext': jobDescription.toString(),
          'nunofQuestions': noOfQuestions.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getInterviewQuestionResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getInterviewQuestionResponse');
      }
    } catch (e) {
      throw Exception("Failed getInterviewQuestionResponse $e");
    }
  }

  // Github Question Response
  Future<Map<String, dynamic>> getCoverLetterResponse(
    int userId,
    String jobTitle,
    String personalSkillTest,
  ) async {
    final url = '$baseUrl/writecoverletter';
    print(
        "Posting in api service $url, $userId, $jobTitle, $personalSkillTest");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userId.toString(),
          'jobtitle': jobTitle.toString(),
          'personalskillltext': personalSkillTest.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getCoverLetterResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getCoverLetterResponse');
      }
    } catch (e) {
      throw Exception("Failed getCoverLetterResponse $e");
    }
  }

  /*IMAGE TOOLS RESPONSE*/
  Future<Map<String, dynamic>> getImageToolsResponse(
      File questionImage,
      int userid,
      String questiontext,
      String subject,
      String gradeclass,
      String toolscode,
      String maxline,
      String isMobile) async {
    final url = '$baseUrl/getimagetoolsresponse/';
    print(
        "Posting in api service $url $questionImage ,$userid, $questiontext, $subject, $gradeclass, $toolscode");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['userid'] = userid.toString();
    request.fields['questiontext'] = questiontext.toString();
    request.fields['subject'] = subject.toString();
    request.fields['gradeclass'] = gradeclass.toString();
    request.fields['toolscode'] = toolscode.toString();
    request.fields['maxSentence'] =
        isMobile.toString() == null ? isMobile.toString() : "50";
    request.fields['isMobileApp'] = "Y";
    request.files.add(
        await http.MultipartFile.fromPath('questionimage', questionImage.path));
    print("QUESTIONIMAGEPATH: ${questionImage.path}");

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      final responseString =
          await response.stream.transform(utf8.decoder).join();
      final responseCheck = json.decode(responseString);
      // final responseCheck = json.decode(await response.stream.bytesToString());
      print("Response check -> $responseCheck");
      /*if (responseCheck["errorcode"] == 200) {
        print('200');*/
      return responseCheck;
      /*} else {
        print('else msg');
        throw Exception(responseCheck["message"]);
      }*/
      /*print("Response in getImageToolsResponse " +
          await response.stream.bytesToString());*/
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
      throw ("Failed getImageToolsResponse ${response.statusCode}");
    }
  }

  /*TOOLS REPLY*/
  Future<Map<String, dynamic>> getToolsReply(
      int userid, int ticketid, String questions, String isMobileApp) async {
    final url = '$baseUrl/gettoolsreply/';
    print(
        "Posting in api service $url, $userid, $ticketid, $questions, $isMobileApp");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'ticketid': ticketid.toString(),
          'questions': questions.toString(),
          'isMobileApp': "Y",
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsReply " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        print("Response in getToolsReply ${response.body}");
        throw Exception('Failed to load data in getToolsReply');
      }
    } catch (e) {
      throw Exception("Failed getToolsReply $e");
    }
  }

  /*GET TOOLS DATA*/
  Future<Map<String, dynamic>> getToolsData(int userid, int ToolsID) async {
    final url = '$baseUrl/gettoolsdata/';
    print("Posting in api service $url, $userid, $ToolsID");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'ToolsID': ToolsID.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsData " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsData');
      }
    } catch (e) {
      throw Exception("Failed getToolsData $e");
    }
  }

  /*GET TOOLS DATA BY CODE*/
  Future<Map<String, dynamic>> getToolsDataByCode(
      int userid, String toolsCode) async {
    final url = '$baseUrl/gettoolsdatabycode/';
    print("Posting in api service $url, $userid, $toolsCode");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'ToolsCode': toolsCode.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsDataByCode " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsDataByCode');
      }
    } catch (e) {
      throw Exception("Failed getToolsDataByCode $e");
    }
  }
}
