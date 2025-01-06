import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/authentication/screens/login/login.dart';
import 'package:talent_lens_hub/navigation_menu.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';
import 'package:talent_lens_hub/utils/helpers/helper_function.dart';

import '../../../../common/widgets/error_dialog.dart';
import '../../../../common/widgets/success_screen/sign_up_success_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../models/user.dart';
import '../../providers/auth_provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  final String password;
  final String otp;

  const VerifyEmailScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.otp});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        /*actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],*/
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //   Image
              Image(
                image: AssetImage(TImages.verifyEmailImage),
                width: THelperFunction.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //   Title and email and subtitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                widget.email,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              /*Text(
                TTexts.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),*/
              TextFormField(
                controller: otpController,
                expands: false,
                cursorColor: TColors.primaryColor,
                decoration: InputDecoration(
                  labelText: "Enter your OTP",
                  hintText: "i.e: 1234",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primaryColor),
                    // Border color when focused
                    borderRadius: BorderRadius.circular(
                        10.0), // Border radius when focused
                  ),
                  prefixIcon: Icon(
                    Iconsax.code,
                    color: TColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              //   Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevent dialog dismissal
                      builder: (BuildContext context) {
                        return Center(
                          child: SpinKitChasingDots(
                            color: TColors.secondaryColor,
                          ), // Show loader
                        );
                      },
                    );
                    if (otpController.text == widget.otp) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false, // Prevent dialog dismissal
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/animations/success-verification.gif",
                                  // width: 100,
                                  height: 100,
                                ),
                                Text(
                                  "Congratulations!!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    "Welcome onboard, Reach at your peak with Talent Lens Hub and Shonod-AI"),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Proceed to Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                            // Show loader
                          );
                        },
                      );
                      /*Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationMenu()),
                        (route) => false,
                      );*/
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("OTP didn't match"),
                        ),
                      );
                    }
                  },
                  child: const Text(TTexts.tContinue),
                ),
              ),
              /*const SizedBox(height: TSizes.spaceBtwItems),
              TextButton(
                onPressed: () {},
                child: const Text(TTexts.resendEmail),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
