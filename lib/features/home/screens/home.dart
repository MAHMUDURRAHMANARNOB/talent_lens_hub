import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/courses/DataModel/TrainingCategoryDataModel.dart';
import 'package:talent_lens_hub/features/courses/RecommandedCoursesForUser/recommendedCoursebyIdProvider.dart';
import 'package:talent_lens_hub/features/courses/RecommandedCoursesForUser/recommendedCoursesDataModel.dart';
import 'package:talent_lens_hub/features/courses/Screens/enrolledCourses.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/ai_helper_container.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/pd_containers.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/primary_header_container.dart';
import 'package:talent_lens_hub/features/subscriptions/screens/SubscriptionPlansScreen.dart';
import 'package:talent_lens_hub/utils/device/device_utility.dart';

import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_shapes/containers/searchContainer.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../courses/CourseContent/screens/LessonListScreen.dart';
import '../../courses/DataModel/EnrolledCoursesDataModel.dart';
import '../../courses/Provider/EnrolledCoursesProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecommendedCourseByIdProvider recommendedCourseByIdProvider =
      RecommendedCourseByIdProvider();
  late int userId;
  late String userName;
  late EnrolledCoursesProvider enrolledCoursesProvider =
      EnrolledCoursesProvider();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    userId = Provider.of<AuthProvider>(context, listen: false).user!.id;
    userName = Provider.of<AuthProvider>(context, listen: false).user!.name!;
    final double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: TColors.primaryColor.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: TColors.primaryColor.withOpacity(0.1),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TTexts.homeAppbarTitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(color: TColors.primaryColor),
                        ),
                        Text(
                          userName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: TColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: TSizes.defaultSpace),

                  // Subscription Plans
                  /*Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubscriptionListScreen(),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("View Subscription Plans")),
                        ),
                      ],
                    ),
                  ),*/
                  // Enrolled courses
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Padding(
                        padding: const EdgeInsets.fromLTRB(
                            TSizes.defaultSpace / 2, 0, 0, 0),
                        child: TSectionHeading(
                          title: "Ongoing Courses",
                          showActionButton: true,
                          buttonTitle: "Show All",
                          textColor: dark ? Colors.white : TColors.primaryColor,
                        ),
                      ),*/
                      //Scrollable Categories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _completedCourseList(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _enrolledCourseList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(height: TSizes.spaceBtwItems),
                  // Recommended Courses

                  //   Categories
                  const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: "Professional Development",
                          showActionButton: false,
                          textColor: TColors.primaryColor,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        //Scrollable Categories
                        Column(
                          children: [
                            // CV BUILDER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PDContainer(
                                    title: "Interview \nQuestion",
                                    // image: TImages.interviewQuestionImage,
                                    icon: Icons.interpreter_mode,
                                    bgColor: Colors.teal,
                                    toolsName: 'Interview Questions',
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Cover Letter
                                Expanded(
                                  child: PDContainer(
                                    title: "Cover \nLetter",
                                    // image: TImages.coverLetterImage,
                                    icon: Iconsax.recovery_convert,
                                    bgColor: TColors.secondaryColor,
                                    toolsName: "Cover Letter",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: TSizes.defaultSpace),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace / 2, vertical: 6.0),
                    child: TSectionHeading(
                      title: "Explore AI tools",
                      showActionButton: false,
                      // buttonTitle: "View All",
                      // onPressed: () {},
                      textColor: TColors.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace / 2),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AiHelperContainer(
                              image: "assets/images/dashboard_images/math.png",
                              title: "Math Solution",
                              color: TColors.primaryColor,
                              toolsName: "Math Solution",
                            ),
                          ),
                          const Expanded(
                            child: AiHelperContainer(
                              image:
                                  "assets/images/dashboard_images/career_counselor.png",
                              title: "Career Counselor",
                              color: TColors.primaryColor,
                              toolsName: "Career Counselor",
                            ),
                          ),
                          const Expanded(
                            child: AiHelperContainer(
                              image:
                                  "assets/images/dashboard_images/life_coach.png",
                              title: "Life Coach",
                              color: TColors.primaryColor,
                              toolsName: "Life Coach",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace / 2),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AiHelperContainer(
                              image:
                                  "assets/images/dashboard_images/mental_health.png",
                              title: "Mental Health",
                              color: TColors.primaryColor,
                              toolsName: "Mental Health",
                            ),
                          ),
                          Expanded(
                            child: AiHelperContainer(
                              image:
                                  "assets/images/dashboard_images/relationship_coach.png",
                              title: "Relationship Coach",
                              color: TColors.primaryColor,
                              toolsName: "Relationship Coach",
                            ),
                          ),
                          Expanded(
                            child: AiHelperContainer(
                              image:
                                  "assets/images/dashboard_images/psychology.png",
                              title: "Psychology",
                              color: TColors.primaryColor,
                              toolsName: "Psychology",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: TSizes.defaultSpace / 2),

                  //   Recommended Courses
                  Visibility(
                    visible: false,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: TSizes.defaultSpace / 2,
                              vertical: 6.0),
                          child: TSectionHeading(
                            title: "Recommended Courses",
                            showActionButton: false,
                            // buttonTitle: "View All",
                            // onPressed: () {},
                            textColor: TColors.primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: TSizes.defaultSpace / 2,
                              top: 6.0,
                              bottom: 6.0),
                          width: double.infinity,
                          height: 100,
                          child: FutureBuilder<void>(
                            future: recommendedCourseByIdProvider
                                .fetchRecommendedCourses(userId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Show a loading indicator while waiting for the response
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                // Show an error message if the API call fails
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                // Handle the success scenario
                                final apiResponse =
                                    recommendedCourseByIdProvider
                                        .recommendedCourseById;
                                if (apiResponse!.courses != null) {
                                  final courses = apiResponse.courses!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: courses.length,
                                    // Disable scrolling of ListView
                                    itemBuilder: (context, index) {
                                      final course = courses[index];
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 200,
                                          decoration: BoxDecoration(
                                            // color: TColors.success.withOpacity(0.2),
                                            border: Border.all(
                                                color: TColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    course.title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: TColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // Handle the case where no courses are found (error scenario)
                                  return Center(
                                      child: Text(apiResponse.message ??
                                          'No courses found'));
                                }
                              } else {
                                // Handle unexpected cases
                                return Center(
                                    child: Text('Something went wrong'));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        } else {
          /*return Container(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
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
                          courseCategoryId: course.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      // color: TColors.success.withOpacity(0.2),
                      border: Border.all(color: TColors.primaryColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            course.courseName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: TColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );*/
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnrolledCourses(),
                ),
              );
            },
            child: Container(
              // width: double.infinity,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              // height: 200,
              // width: 200,
              decoration: BoxDecoration(
                  color: TColors.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: TColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      "assets/images/dashboard_images/progress_icon.png",
                      color: Colors.white,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "${enrolledCoursesProvider.enrolledCourses.length.toString()} Courses",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                  ),
                  Text(
                    "In Progress",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _completedCourseList() {
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
        } else {
          return Container(
            // width: double.infinity,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            // height: 200,
            // width: 200,
            decoration: BoxDecoration(
                color: TColors.secondaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16.0)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: TColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    "assets/images/dashboard_images/completed_courses_icon.png",
                    color: Colors.white,
                    height: 60,
                    width: 60,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "0 Courses",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                ),
                Text(
                  "Completed",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
