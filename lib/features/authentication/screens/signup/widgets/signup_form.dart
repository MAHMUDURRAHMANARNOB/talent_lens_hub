import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../providers/auth_provider.dart';
import '../TermsAndConditionsDialog.dart';
import '../verify_email.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  // Initially hide the password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
      child: Column(
        children: [
          // First Name and Last Name
          TextFormField(
            controller: fullNameController,
            expands: false,
            cursorColor: TColors.primaryColor,
            decoration: InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your full name",
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: TColors.primaryColor), // Border color when focused
                borderRadius:
                    BorderRadius.circular(10.0), // Border radius when focused
              ),
              prefixIcon: Icon(
                Iconsax.user,
                color: TColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //   UserName

          //   Phone No
          TextFormField(
            controller: phoneNumberController,
            expands: false,
            cursorColor: TColors.primaryColor,
            decoration: InputDecoration(
              labelText: TTexts.phoneNo,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: TColors.primaryColor), // Border color when focused
                borderRadius:
                    BorderRadius.circular(10.0), // Border radius when focused
              ),
              prefixIcon: Icon(Iconsax.call, color: TColors.primaryColor),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          //   Email
          TextFormField(
            controller: emailController,
            expands: false,
            cursorColor: TColors.primaryColor,
            decoration: InputDecoration(
              labelText: TTexts.email,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: TColors.primaryColor), // Border color when focused
                borderRadius:
                    BorderRadius.circular(10.0), // Border radius when focused
              ),
              prefixIcon: Icon(Iconsax.direct, color: TColors.primaryColor),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //   Password
          TextFormField(
            controller: passwordController,
            cursorColor: TColors.primaryColor,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: TTexts.password,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: TColors.primaryColor), // Border color when focused
                borderRadius:
                    BorderRadius.circular(10.0), // Border radius when focused
              ),
              prefixIcon: Icon(
                Iconsax.password_check,
                color: TColors.primaryColor,
              ),
              suffixIcon: IconButton(
                onPressed: _togglePasswordVisibility,
                icon: Icon(
                  _obscureText ? Iconsax.eye : Iconsax.eye_slash,
                  color: TColors.darkGrey,
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //   Terms and condition
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: true,
                  activeColor: TColors.primaryColor,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showTermsAndConditionsDialog(context);
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "I accept the ",
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                          text: "Privacy Policy and Terms and Conditions",
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                                color: widget.dark
                                    ? TColors.white
                                    : TColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: widget.dark
                                    ? TColors.white
                                    : TColors.primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          //   Signup Button
          /*SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                */ /*Get.to(() => const VerifyEmailScreen());*/ /*
              },
              child: const Text(TTexts.createAccount),
            ),
          ),*/
          authProvider.isLoading
              ? CircularProgressIndicator(color: TColors.primaryColor)
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyEmailScreen(
                            email: emailController.text,
                            password: passwordController.text,
                            otp: "1234",
                          ),
                        ),
                      );*/
                      await authProvider.signUpUser(
                        name: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneNumberController.text,
                        userType: "J",
                      );

                      final response = authProvider.signupResponse;

                      if (response != null && response.success) {
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Sign up successful! OTP: ${response.userOtp}")),
                        );*/
                        print("Sign up successful! OTP: ${response.userOtp}");
                        // Navigator.push(context, route)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyEmailScreen(
                              email: emailController.text,
                              password: passwordController.text,
                              otp: response.userOtp.toString(),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Error: ${response?.message}")),
                        );
                      }
                    },
                    child: Text("Proceed"),
                  ),
                ),
        ],
      ),
    );
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TermsAndConditionsDialog(); // Call TermsAndConditionsDialog to display the dialog
      },
    );
  }
}
