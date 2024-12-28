import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:talent_lens_hub/features/courses/DataModel/TrainingCategoryDataModel.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/ai_helper_container.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/home_app_bar.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/pd_containers.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/primary_header_container.dart';
import 'package:talent_lens_hub/utils/device/device_utility.dart';

import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_shapes/containers/searchContainer.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../courses/DataModel/EnrolledCoursesDataModel.dart';
import '../../courses/Provider/EnrolledCoursesProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int userId;
  late EnrolledCoursesProvider enrolledCoursesProvider =
      EnrolledCoursesProvider();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    userId = 1;
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
            Column(
              children: [
                const THomeAppBar(),
                // SizedBox(height: TSizes.defaultSpace),

                // Enrolled courses
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          TSizes.defaultSpace / 2, 0, 0, 0),
                      child: TSectionHeading(
                        title: "Ongoing Courses",
                        showActionButton: true,
                        buttonTitle: "Show All",
                        textColor: dark ? Colors.white : TColors.primaryColor,
                      ),
                    ),
                    //Scrollable Categories
                    _enrolledCourseList(),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                // Recommended Courses
                /*Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: "Popular Courses",
                        buttonTitle: "Show All",
                        showActionButton: true,
                        textColor: TColors.primaryColor,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              // width: 250,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                // color: TColors.primaryColor.withOpacity(0.2),
                                border: Border.all(
                                  color: TColors.primaryColor,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          dark
                                              ? "assets/images/dashboard_images/career_dark.png"
                                              : "assets/images/dashboard_images/career_counselor.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Text("4.8"),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Digital Marketing",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Total Enrolled:"),
                                      Text(
                                        "1260",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              // width: 250,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                // color: TColors.primaryColor.withOpacity(0.2),
                                border: Border.all(
                                  color: TColors.primaryColor,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          dark
                                              ? "assets/images/dashboard_images/career_dark.png"
                                              : "assets/images/dashboard_images/career_counselor.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Text("4.8"),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amberAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Digital Marketing",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Total Enrolled:"),
                                      Text(
                                        "1260",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/

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
                                  title: "CV Builder",
                                  // image: TImages.cvBuilderImage,
                                  icon: Icons.remove_from_queue,
                                  bgColor: TColors.primaryColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              // Cover Letter
                              Expanded(
                                child: PDContainer(
                                  title: "Cover Letter",
                                  // image: TImages.coverLetterImage,
                                  icon: Iconsax.recovery_convert,
                                  bgColor: TColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          // INTERVIEW QUESTION
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PDContainer(
                                  title: "Interview \nQuestion",
                                  // image: TImages.interviewQuestionImage,
                                  icon: Icons.interpreter_mode,
                                  bgColor: Colors.teal,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: PDContainer(
                                  title: "Exam Preparation",
                                  // image: TImages.examPreparationImage,
                                  icon: Icons.star,
                                  bgColor: Colors.brown,
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
                      horizontal: TSizes.defaultSpace, vertical: 6.0),
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
                            staticToolsCode: '',
                          ),
                        ),
                        const Expanded(
                          child: AiHelperContainer(
                            image:
                                "assets/images/dashboard_images/career_counselor.png",
                            title: "Career Counselor",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                        const Expanded(
                          child: AiHelperContainer(
                            image:
                                "assets/images/dashboard_images/life_coach.png",
                            title: "Life Couch",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: TSizes.defaultSpace / 2),
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
                            staticToolsCode: '',
                          ),
                        ),
                        Expanded(
                          child: AiHelperContainer(
                            image:
                                "assets/images/dashboard_images/relationship_coach.png",
                            title: "Relationship Coach",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                        Expanded(
                          child: AiHelperContainer(
                            image:
                                "assets/images/dashboard_images/psychology.png",
                            title: "Psychology",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
          return Container(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final EnrolledCoursesDataModel course =
                    enrolledCoursesProvider.enrolledCourses[index];
                return Container(
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
                );
              },
            ),
          );
        }
      },
    );
  }
}
