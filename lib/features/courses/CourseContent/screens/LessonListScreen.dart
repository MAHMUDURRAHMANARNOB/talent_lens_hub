import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../Provider/CourseContentProvider.dart';
import 'LessonBoardScreen.dart';

class LessonListScreen extends StatefulWidget {
  final String courseTitle;
  final int courseCategoryId;
  final bool isEnrolled;

  const LessonListScreen(
      {super.key,
      required this.courseTitle,
      required this.courseCategoryId,
      required this.isEnrolled});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final CourseContentProvider courseContentProvider = CourseContentProvider();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    late bool isEnrolled = widget.isEnrolled;

    return Scaffold(
      appBar: AppBar(title: Text('Course Content')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<void>(
              future: courseContentProvider
                  .fetchCourseContent(widget.courseCategoryId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitCircle(color: TColors.primaryColor));
                } else if (snapshot.hasError) {
                  return Center(child: Text("An error occurred!"));
                } else {
                  final courseContent = courseContentProvider.courses;
                  final lessons = courseContentProvider.lessons;
                  final chapters = courseContentProvider.lessons
                      .where((lesson) => lesson.isChapter == "Y")
                      .toList();
                  // final chapters = courseContentProvider.chapters;
                  // final regularLessons = courseContentProvider.regularLessons;
                  final chapterLessonsMap =
                      courseContentProvider.chapterLessonsMap;

                  if (lessons.isEmpty && courseContent.isEmpty) {
                    return Center(child: Text("No Lesson available."));
                  }
                  print(chapterLessonsMap.length);
                  return Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courseContent[0].courseName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            // border: Border.all(color: TColors.primaryColor),
                          ),
                          child: Text(
                            courseContent[0].courseDescription,
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        Visibility(
                          visible: !isEnrolled,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.secondaryColor,
                              elevation: 6,
                              side: BorderSide(color: TColors.secondaryColor),
                            ),
                            onPressed: () {},
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Enroll now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline_outlined,
                                        size: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      "Total Enrolled Students: ",
                                    ),
                                    Text(
                                      courseContent[0].enrolled.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: TColors.primaryColor),
                                      // textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline_outlined,
                                        size: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      "Difficulty Level: ",
                                    ),
                                    Text(
                                      courseContent[0]
                                          .difficultyLevel
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: TColors.primaryColor),
                                      // textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline_outlined,
                                        size: 24),
                                    SizedBox(width: 10),
                                    Text(
                                      "Skills: ",
                                    ),
                                    Expanded(
                                      child: Text(
                                        courseContent[0].tagText.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: TColors.primaryColor),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Chapters:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: TColors.secondaryColor,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];
                            final chapter = lessons[index];

                            return chapter.isChapter == "Y"
                                ? Container(
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      /*color: lesson.isFree == 'Y'
                                          ? TColors.success.withOpacity(0.1)
                                          : TColors.info.withOpacity(0.1),*/
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      lesson.lessonTitle,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    /*Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0,
                                                              vertical: 5.0),
                                                      decoration: BoxDecoration(
                                                        color: lesson.isFree ==
                                                                'Y'
                                                            ? TColors.success
                                                            : TColors.info,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          6.0,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        lesson.isFree == 'Y'
                                                            ? "Free"
                                                            : "Member",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )*/
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10.0),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      isEnrolled
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonBoardScreen(
                                                        lessonTitle:
                                                            lesson.lessonTitle,
                                                        lessonId: lesson.id),
                                              ),
                                            )
                                          : lesson.isFree != "N"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LessonBoardScreen(
                                                            lessonTitle: lesson
                                                                .lessonTitle,
                                                            lessonId:
                                                                lesson.id),
                                                  ),
                                                )
                                              : showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.asset(
                                                              "assets/images/apology.png"),
                                                          Text(
                                                            "Sorry!",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 30),
                                                          ),
                                                          Text(
                                                            "You have to enroll first to access this course content",
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          ElevatedButton(
                                                            onPressed: () {},
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                "Enroll Now",
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: lesson.isFree == 'Y' ||
                                                lesson.isFree == "M"
                                            ? TColors.success.withOpacity(0.1)
                                            : TColors.secondaryColor
                                                .withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            64),
                                                    color: TColors.white,
                                                  ),
                                                  child: Icon(
                                                    Iconsax.book,
                                                    size: 20.0,
                                                    color: lesson.isFree ==
                                                                'Y' ||
                                                            lesson.isFree == "M"
                                                        ? TColors.success
                                                        : TColors
                                                            .secondaryColor,
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        lesson.lessonTitle,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: lesson.isFree ==
                                                                      'Y' ||
                                                                  lesson.isFree ==
                                                                      "M"
                                                              ? TColors.success
                                                              : TColors
                                                                  .secondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            6.0,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          lesson.isFree ==
                                                                      'Y' ||
                                                                  lesson.isFree ==
                                                                      "M"
                                                              ? "View"
                                                              : "Enroll",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: lesson.isFree == 'Y'
                                                      ? TColors.success
                                                      : TColors.info,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
