import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_lens_hub/features/authentication/screens/onBoarding/widgets/onboarding_dot_navigation.dart';
import 'package:talent_lens_hub/features/authentication/screens/onBoarding/widgets/onboarding_next_button.dart';
import 'package:talent_lens_hub/features/authentication/screens/onBoarding/widgets/onboarding_page.dart';
import 'package:talent_lens_hub/features/authentication/screens/onBoarding/widgets/onboarding_skip.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:talent_lens_hub/utils/constants/image_strings.dart';
import 'package:talent_lens_hub/utils/device/device_utility.dart';
import 'package:talent_lens_hub/utils/helpers/helper_function.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Skip Button
            // const OnBoardingSkip(),

            //Horizontal Scrollable Pages
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: const [
                OnBoardingPage(
                  image: TImages.onBoardingImage1,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1,
                  description: TTexts.onBoardingDescription1,
                ),
                OnBoardingPage(
                  image: TImages.onBoardingImage2,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2,
                  description: TTexts.onBoardingDescription2,
                ),
                OnBoardingPage(
                  image: TImages.onBoardingImage3,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3,
                  description: TTexts.onBoardingDescription3,
                ),
              ],
            ),

            // Dot Navigation SmoothPageIndicator
            const OnBoardingDotNavigation(),

            //Circular Button
            const OnBoardingNextButton(),
          ],
        ),
      ),
    );
  }
}
