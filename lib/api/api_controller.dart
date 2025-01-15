import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/authentication/models/CreateUserResponse.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CheckCourseEnrollmentDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/CourseListDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/EnrolledCoursesDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonQuestionAnswerDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/LessonVideosDataModel.dart';
import 'package:talent_lens_hub/features/courses/DataModel/TrainingCategoryDataModel.dart';

import '../features/ToolsContent/datamodel/studyToolsDataModel.dart';
import '../features/authentication/models/login_response.dart';
import '../features/courses/DataModel/CourseContentDataModel.dart';
import '../features/courses/DataModel/CourseEnrollDataModel.dart';
import '../features/courses/DataModel/VideoQuestionResponseDataModel.dart';
import '../features/courses/RecommandedCoursesForUser/recommendedCoursesDataModel.dart';
import '../features/subscriptions/datamodels/subscriptionPlansDataModel.dart';

class ApiController {
  static const String baseUrl = 'https://testapi.talentlenshub.com';

  static const String webURL = 'https://demoapi.talentlenshub.com/api';

  // Login

  static Future<LoginResponse> loginApi(String email, String? password) async {
    print("Im here");
    const apiUrl = '$webURL/auth/signin';

    final Uri uri = Uri.parse(apiUrl);

    final Map<String, dynamic> body = {
      'email': email.toString(),
      // 'password': password, // "N" for manual, "Y" for social login
    };
    // Add 'password' only if it's not null
    if (password != null) {
      body['password'] = password.toString();
    }

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body.entries
            .map((entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
            .join('&'),
      );

      if (response.statusCode == 200) {
        // Parse successful response
        print(jsonDecode(response.body));
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        print("HTTP Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        throw Exception('Failed to login. HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error during loginApi: $error");
      throw Exception('Failed to login. Error: $error');
    }
  }

  // Signup
  /*static Future<CreateUserResponse> createUser(
    String name,
    String email,
    String? password,
    String? mobile,
    String userType,
    File? cvFile,
  ) async {
    const apiUrl = '$webURL/auth/signup';

    try {
      final body = <String, dynamic>{
        'name': name.toString(),
        'email': email.toString(),
        'usertype': userType.toString(),
      };

      // Add 'password' only if it's not null
      if (password != null) {
        body['password'] = password.toString();
      }
      if (mobile != null) {
        body['phone'] = mobile.toString();
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body.entries
            .map((entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
            .join('&'),
        // body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Parse successful response
        final responseData = jsonDecode(response.body);
        if (responseData["errorcode"] == 200) {
          print("Success Response: ${response.body}");
          */ /*SuccessfulResponse.fromJson(jsonDecode(response.body));*/ /*
          return true;
        } else if (responseData["errorcode"] == 400) {
          print("Failed to create user: ${responseData["message"]}");
          */ /*ErrorResponse.fromJson(jsonDecode(response.body));*/ /*
          return false;
        } else {
          print("Failed to create user: ${response.body}");
          return false;
        }
      } else {
        // Parse error response
        print("Failed to create user: StatusCode ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Exception occurred
      print('Exception creating user: $e');
      return false;
    }
  }*/
  Future<SignUpResponse> createUser({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? userType,
    File? cvFile,
  }) async {
    final url = Uri.parse("$webURL/auth/signup");
    final Map<String, dynamic> body = {
      'name': name.toString(),
      'email': email.toString(),
      'userType': "J",
      // 'password': password, // "N" for manual, "Y" for social login
    };
    // Add 'password' only if it's not null
    if (password != null) {
      body['password'] = password.toString();
    }
    if (phone != null) {
      body['phone'] = phone.toString();
    }
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body.entries
            .map((entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}')
            .join('&'),
        /*body: jsonEncode({
          'email': email,
          'password': password,
          'phone': phone,
        }),*/
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));
        // Success response
        return SignUpResponse.fromJson(jsonDecode(response.body));
      } else {
        // Handle error response
        return SignUpResponse.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      // Handle exceptions
      return SignUpResponse(
        success: false,
        message: "An error occurred: ${e.toString()}",
      );
    }
  }

  /// Fetch dashboard activity for a specific user ID
  Future<Map<String, dynamic>> fetchUserStates(int userId) async {
    final String url = "$webURL/training/dashboard_activity/$userId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the response body
        return jsonDecode(response.body);
      } else {
        // Handle non-successful response
        throw Exception(
            "Failed to load dashboard activity: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network or other errors
      throw Exception("Error occurred while fetching data: $e");
    }
  }

  // Subscription Plans
  Future<List<SubscriptionPlan>> getSubscriptions() async {
    final url = Uri.parse('$webURL/subscription/get_subscription');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        // print(jsonData);
        return jsonData.map((json) => SubscriptionPlan.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load subscriptions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subscriptions: $e');
    }
  }

  // Initiate Payment
  static Future<void> initiatePayment(
    int userId,
    int subscriptionid,
    String transactionid,
    double amount,
  ) async {
    final url = '$baseUrl/initiatepayment';
    print("Posting in api service $url");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userId.toString(),
          'subscriptionid': subscriptionid.toString(),
          'transactionid': transactionid.toString(),
          'amount': amount.toString(),
        },
      );
      print("Response:   ${response.statusCode}");
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Response in initiatePayment else" + response.body);
        throw Exception('Failed to load data in getPackagesList');
      }
    } catch (e) {
      print("Response in initiatePayment Catch" + e.toString());
      throw Exception("Failed getPackagesList $e");
    }
  }

  // Receive payment
  static Future<void> receivePayment(
    int userId,
    int subscriptionid,
    String transactionid,
    String transStatus,
    double amount,
    String storeamount,
    String cardno,
    String banktran_id,
    String currency,
    String card_issuer,
    String card_brand,
    String card_issuer_country,
    String risk_level,
    String risk_title,
  ) async {
    final url = '$baseUrl/receivepayment';
    print("Posting in api service $url");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userId.toString(),
          'subscriptionid': subscriptionid.toString(),
          'paytransid': transactionid.toString(),
          'transStatus': transStatus.toString(),
          'amount': amount.toString(),
          'storeamount': storeamount.toString(),
          'cardno': cardno.toString(),
          'banktran_id': banktran_id.toString(),
          'currency': currency.toString(),
          'card_issuer': card_issuer.toString(),
          'card_brand': card_brand.toString(),
          'card_issuer_country': card_issuer_country.toString(),
          'risk_level': risk_level.toString(),
          'risk_title': risk_title.toString(),
        },
      );
      print("Response:   ${response.statusCode}");
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Response in receivePayment else" + response.body);
        throw Exception('Failed to load data in getPackagesList');
      }
    } catch (e) {
      print("Response in receivePayment Catch" + e.toString());
      throw Exception("Failed getPackagesList $e");
    }
  }

  // Course Category List
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

  Future<CheckEnrollmentDataModel?> checkIfCourseEnrolled(
      int courseId, int userId) async {
    final url = "$webURL/training/enroll_courses/$courseId/$userId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(response.body);
          return CheckEnrollmentDataModel.fromJson(data);
        } else {
          return null; // When the response is `null`
        }
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }

  Future<CourseEnrollmentResponse> enrollInCourse(
      String userId, String courseId) async {
    print("Hi");
    try {
      final response = await http.post(
        Uri.parse("$webURL/training/course_enroll"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'userId': userId,
          'courseId': courseId,
        },
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return CourseEnrollmentResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to enroll course');
      }
    } catch (e) {
      throw Exception('Error: $e');
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

  // fetch video lesson answer
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

  // fetch video lesson answer
  Future<Map<String, dynamic>> fetchLessonQuestionAnswer({
    required String question,
    required String lessonAnswerId,
    required int userId,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/answerquestion/");

      final response = await http.post(
        uri,
        body: {
          'question': question.toString(),
          'lessonansID': lessonAnswerId.toString(),
          'userid': userId.toString(),
        },
      );
      // print("Response  $response");

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        // print("Response Body: $responseBody");

        /*final jsonResponse = jsonDecode(responseBody);
        return jsonResponse;*/
        final jsonResponse = jsonDecode(responseBody);
        if (jsonResponse is Map<String, dynamic>) {
          return jsonResponse;
        } else {
          throw Exception('Invalid JSON structure received.');
        }
      } else {
        print("Error Status Code: ${response.statusCode}");
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

  Future<Map<String, dynamic>> getMathImageResponse(
    File questionImage,
    int userid,
    String? questiontext,
  ) async {
    const url = '$baseUrl/SolvebanglaMath/';
    print("Posting in api service $url $questionImage ,$userid, $questiontext");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['userid'] = userid.toString();
    request.fields['questiontext'] = questiontext.toString();
    request.files.add(
        await http.MultipartFile.fromPath('mathPhoto', questionImage!.path));
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
      print("Response  ${response.statusCode}");
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

  // Cover Letter Response
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

//   Start Course Exam
  Future<Map<String, dynamic>> startCourseExam({
    required String userId,
    required String courseId,
    String? examPaperId,
    String? questionId,
    String? ansId,
  }) async {
    final url = Uri.parse("$baseUrl/StartcourseExam");
    // Creating a form-data body
    final request = http.MultipartRequest("POST", url)
      ..fields["userid"] = userId
      ..fields["courseId"] = courseId;

    if (examPaperId != null) request.fields["examPaperId"] = examPaperId;
    if (questionId != null) request.fields["questionID"] = questionId;
    if (ansId != null) request.fields["ansID"] = ansId;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final utf8Body = utf8.decode(response.bodyBytes);
      // print(json.decode(utf8Body));
      return json.decode(utf8Body);
    } else {
      throw Exception("Failed to fetch data: ${response.body}");
    }
  }

//   RecommendedCourses
  Future<RecommendedCoursesDataModel> recommendCoursesForUser(
      String userId) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/recommendCoursesforuser"),
        body: {'userid': userId},
      );

      if (response.statusCode == 200) {
        // Decode response body with UTF-8
        var decodedResponse = json.decode(utf8.decode(response.bodyBytes));

        // Parse the response using the RecommendedCoursesDataModel
        return RecommendedCoursesDataModel.fromJson(decodedResponse);
      } else {
        // Handle non-200 status codes
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions
      throw Exception("Failed to load courses: $e");
    }
  }
}
