import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
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
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  // Appbar
                  THomeAppBar(),
                  // SizedBox(height: TSizes.defaultSpace),
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
                    padding: EdgeInsets.all(TSizes.defaultSpace / 2),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: "Personal Development",
                          showActionButton: false,
                          // buttonTitle: "View All",
                          // onPressed: () {},
                          textColor: TColors.primaryColor,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        //Scrollable Categories
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                /*SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),*/
                                // Cover Letter
                                TCardContainerButton(
                                  child: PDContainer(
                                    title: "Cover Letter",
                                    image: TImages.coverLetterImage,
                                    bgColor: TColors.secondaryColor,
                                  ),
                                ),
                                /*SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),*/
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
                                /*SizedBox(
                                  height: TSizes.spaceBtwItems / 2,
                                ),*/
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: TSectionHeading(
                title: "Solutions From AI",
                showActionButton: false,
                // buttonTitle: "View All",
                // onPressed: () {},
                textColor: TColors.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace / 2),
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
              padding: EdgeInsets.all(TSizes.defaultSpace / 2),
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
