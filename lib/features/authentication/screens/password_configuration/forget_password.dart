import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:talent_lens_hub/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';
import 'package:talent_lens_hub/utils/constants/text_strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //    Heading
            Text(
              TTexts.forgePasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.forgePasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems * 2),

            //   Text Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: TTexts.email,
                // hintText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            //   Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.off(const ResetPasswordScreen());
                },
                child: Text(TTexts.tContinue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
