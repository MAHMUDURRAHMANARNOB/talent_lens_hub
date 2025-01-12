import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/colors.dart';
import '../../authentication/providers/auth_provider.dart';
import '../CourseContent/screens/LessonListScreen.dart';
import '../DataModel/EnrolledCoursesDataModel.dart';
import '../Provider/EnrolledCoursesProvider.dart';

class EnrolledCourses extends StatefulWidget {
  const EnrolledCourses({super.key});

  @override
  State<EnrolledCourses> createState() => _EnrolledCoursesState();
}

class _EnrolledCoursesState extends State<EnrolledCourses> {
  late int userId;
  late EnrolledCoursesProvider enrolledCoursesProvider =
      EnrolledCoursesProvider();

  @override
  Widget build(BuildContext context) {
    userId = Provider.of<AuthProvider>(context, listen: false).user!.id;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ongoing Courses",
                style: TextStyle(fontSize: 30.0),
              ),
              Divider(color: TColors.primaryColor),
              _enrolledCourseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _enrolledCourseList() {
    return FutureBuilder(
      future: enrolledCoursesProvider.getEnrolledCourses(userId.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitWave(
            color: TColors.primaryColor,
            size: 20,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (enrolledCoursesProvider.enrolledCourses.isEmpty) {
          return Center(child: Text('No Courses Available at this moment'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            itemCount: enrolledCoursesProvider.enrolledCourses.length,
            itemBuilder: (context, index) {
              final EnrolledCoursesDataModel course =
                  enrolledCoursesProvider.enrolledCourses[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonListScreen(
                        courseTitle: course.courseName,
                        courseId: course.id,
                        isEnrolled: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  // width: 200,
                  decoration: BoxDecoration(
                    color: TColors.primaryColor.withOpacity(0.07),
                    // border: Border.all(color: TColors.primaryColor),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${course.lessonCount.toString()} Lessons",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: TColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              course.courseName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: TColors.white,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                course.isExamTaken == "N"
                                    ? "Exam Pending"
                                    : "Download Certificate",
                                style: TextStyle(
                                  color: course.isExamTaken == "N"
                                      ? TColors.secondaryColor
                                      : TColors.success,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(64.0),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: TColors.primaryColor,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
