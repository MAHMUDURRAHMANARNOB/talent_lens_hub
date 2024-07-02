import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/ai_helper_container.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/home_app_bar.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/pd_containers.dart';
import 'package:talent_lens_hub/features/home/screens/widgets/primary_header_container.dart';
import 'package:talent_lens_hub/utils/device/device_utility.dart';

import '../../../common/widgets/custom_shapes/containers/searchContainer.dart';
import '../../../common/widgets/texts/section_heading.dart';
import '../../../utils/constants/colors.dart';
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
                  THomeAppBar(),
                  const SizedBox(height: TSizes.defaultSpace),
                  //   SearchBar
                  /*TSearchContainer(
                    text: 'Search',
                    icon: Iconsax.search_normal,
                    showBackground: true,
                    showBorder: true,
                  ),*/
                  // const SizedBox(height: TSizes.spaceBtwSections),

                  //   Categories
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
                      children: [
                        const TSectionHeading(
                          title: "Personal Development",
                          showActionButton: false,
                          // buttonTitle: "View All",
                          // onPressed: () {},
                          textColor: TColors.primaryColor,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        //Scrollable Categories
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // CV BUILDER
                            PDContainer(
                              title: "CV Builder",
                              image:
                                  "assets/images/dashboard_images/cv_builder.png",
                              bgColor: TColors.primaryColor,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems / 2,
                            ),
                            // Cover Letter
                            PDContainer(
                              title: "Cover Letter",
                              image:
                                  "assets/images/dashboard_images/cover_letter.png",
                              bgColor: TColors.secondaryColor,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems / 2,
                            ),
                            // INTERVIEW QUESTION
                            PDContainer(
                              title: "Interview Question",
                              image:
                                  "assets/images/dashboard_images/interview_question.png",
                              bgColor: Colors.indigoAccent,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems / 2,
                            ),
                            PDContainer(
                              title: "Exam Preparation",
                              image:
                                  "assets/images/dashboard_images/interview_question.png",
                              bgColor: Colors.green,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: const TSectionHeading(
                title: "Solutions From AI",
                showActionButton: false,
                // buttonTitle: "View All",
                // onPressed: () {},
                textColor: TColors.primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    AiHelperContainer(
                      image: "assets/images/dashboard_images/maths.png",
                      title: "Math Solution",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    AiHelperContainer(
                      image:
                          "assets/images/dashboard_images/career_counselor.png",
                      title: "Career Counselor",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    AiHelperContainer(
                      image: "assets/images/dashboard_images/life_coach.png",
                      title: "Life Couch",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    AiHelperContainer(
                      image: "assets/images/dashboard_images/mental_health.png",
                      title: "Mental Health",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    AiHelperContainer(
                      image:
                          "assets/images/dashboard_images/relationship_coach.png",
                      title: "Relationship Coach",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    AiHelperContainer(
                      image: "assets/images/dashboard_images/psychology.png",
                      title: "Psychology",
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
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
