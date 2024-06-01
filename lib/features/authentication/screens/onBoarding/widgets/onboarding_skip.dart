import 'package:flutter/material.dart';
import 'package:talent_lens_hub/features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          print("Skip button pressed");
          OnboardingController.instance.skipPage();
        },
        child: Text("Skip"),
      ),
    );
  }
}
