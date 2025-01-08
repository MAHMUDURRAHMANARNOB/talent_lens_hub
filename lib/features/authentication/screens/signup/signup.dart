import 'package:flutter/material.dart';
import 'package:talent_lens_hub/common/widgets/login_signup/form_divider.dart';
import 'package:talent_lens_hub/common/widgets/login_signup/social_buttons.dart';
import 'package:talent_lens_hub/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';
import 'package:talent_lens_hub/utils/helpers/helper_function.dart';

import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //Form
              TSignupForm(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections),

              //   Divider
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    TFormDivider(dark: dark, dividerText: TTexts.orSignUpWith),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    //   Social icons
                    const TSocialButtons(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
