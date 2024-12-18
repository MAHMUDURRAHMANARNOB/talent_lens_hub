import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> carosole = [
    Container(
      color: Colors.red,
      child: Center(
          child: Text('Item 1',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    ),
    Container(
      color: Colors.green,
      child: Center(
          child: Text('Item 2',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    ),
    Container(
      color: Colors.blue,
      child: Center(
          child: Text('Item 3',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    ),
  ];

  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunction.isDarkMode(context);
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      TSizes.defaultSpace / 2, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TSectionHeading(
                        title: "Ongoing Courses",
                        showActionButton: false,
                        textColor: TColors.primaryColor,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      //Scrollable Categories
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 200,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  // color: TColors.primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: TColors.primaryColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      flex: 1,
                                      child: Text(
                                        "Python for Beginners",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    // SizedBox(width: 10.0),
                                    CircularPercentIndicator(
                                      radius: 20.0,
                                      animation: true,
                                      animationDuration: 500,
                                      lineWidth: 5.0,
                                      percent: 0.4,
                                      center: new Text(
                                        "40%",
                                        style: new TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      // backgroundColor: Colors.white70,
                                      progressColor: TColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                width: 200,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  // color: TColors.primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: TColors.primaryColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Flexible(
                                      flex: 1,
                                      child: Text(
                                        "Android with kotlin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    // SizedBox(width: 10.0),
                                    CircularPercentIndicator(
                                      radius: 20.0,
                                      animation: true,
                                      animationDuration: 500,
                                      lineWidth: 5.0,
                                      percent: 0.6,
                                      center: new Text(
                                        "60%",
                                        style: new TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      // backgroundColor: Colors.white70,
                                      progressColor: TColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Recommended Courses
                Padding(
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
                                          "assets/images/dashboard_images/career_counselor.png",
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
                                          "assets/images/dashboard_images/career_counselor.png",
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
                ),

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
                            image: "assets/images/dashboard_images/math.png",
                            title: "Math Solution",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                        Expanded(
                          child: AiHelperContainer(
                            image:
                                "assets/images/dashboard_images/career_counselor.png",
                            title: "Career Counselor",
                            color: TColors.primaryColor,
                            staticToolsCode: '',
                          ),
                        ),
                        Expanded(
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
}
