import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/ai_helper_container.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/card_container_button.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/home_app_bar.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/pd_containers.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/primary_header_container.dart';
import 'package:talent_lens_hub/utils/device/device_utility.dart';

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
  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  const THomeAppBar(),
                  // SizedBox(height: TSizes.defaultSpace),
                  // courses
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
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
                                        progressColor: Colors.green,
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
                                        progressColor: Colors.green,
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
                                TCardContainerButton(
                                  child: PDContainer(
                                    title: "CV Builder",
                                    image: TImages.cvBuilderImage,
                                    bgColor: TColors.primaryColor,
                                  ),
                                ),
                                // Cover Letter
                                TCardContainerButton(
                                  child: PDContainer(
                                    title: "Cover Letter",
                                    image: TImages.coverLetterImage,
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
                                TCardContainerButton(
                                  // color: Colors.green,
                                  child: PDContainer(
                                    title: "Interview \nQuestion",
                                    image: TImages.interviewQuestionImage,
                                    bgColor: Colors.teal,
                                  ),
                                ),
                                TCardContainerButton(
                                  child: PDContainer(
                                    title: "Exam \nPreparation",
                                    image: TImages.examPreparationImage,
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
                        image: "assets/images/dashboard_images/life_coach.png",
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
                        image: "assets/images/dashboard_images/psychology.png",
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
      ),
    );
  }
}
