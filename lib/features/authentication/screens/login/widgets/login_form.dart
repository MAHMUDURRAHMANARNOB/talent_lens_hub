import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:talent_lens_hub/features/authentication/screens/signup/signup.dart';
import 'package:talent_lens_hub/navigation_menu.dart';

import '../../../../../common/widgets/error_dialog.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';

class TLoginForm extends StatefulWidget {
  final Function(String, String) onLoginSuccess; //Callback function

  const TLoginForm({
    super.key,
    required this.onLoginSuccess,
  });

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
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
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              cursorColor: TColors.primaryColor,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.direct,
                  color: TColors.primaryColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TColors.primaryColor), // Border color when focused
                  borderRadius:
                      BorderRadius.circular(10.0), // Border radius when focused
                ),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: passwordController,
              cursorColor: TColors.primaryColor,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Iconsax.password_check, color: TColors.primaryColor),
                labelText: TTexts.password,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TColors.primaryColor), // Border color when focused
                  borderRadius:
                      BorderRadius.circular(10.0), // Border radius when focused
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
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            //   Remember Me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///RememberMe
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: TColors.primaryColor,
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                ///ForgetPass
                TextButton(
                  onPressed: () {
                    Get.to(const ForgetPasswordScreen());
                  },
                  child: const Text(
                    TTexts.forgetPassword,
                    style: TextStyle(color: TColors.secondaryColor),
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            //   Sign In Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const NavigationMenu(),
                    ),
                  );*/
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
                              "assets/icons/light_icon.png",
                              width: 50,
                              height: 50,
                            ),
                            SpinKitChasingDots(
                              color: TColors.primaryColor,
                            ),
                          ],
                        ), // Show loader
                      );
                    },
                  );
                  try {
                    String email = emailController.text;
                    String password = passwordController.text;
                    // Call the login method from the AuthProvider
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(email, password);
                    Navigator.pop(context);
                    // Check if the user is authenticated
                    if (Provider.of<AuthProvider>(context, listen: false)
                            .user !=
                        null) {
                      AppUser user =
                          Provider.of<AuthProvider>(context, listen: false)
                              .user!;
                      print("User ID: ${user.id}");
                      print("Name: ${user.name}");
                      print("Username: ${user.username}");

                      // Navigate to the DashboardScreen on successful login
                      /* Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationMenu(),
                        ),
                      );*/
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationMenu()),
                        (route) => false,
                      );
                      widget.onLoginSuccess(email, password);
                    } else {
                      // Handle unsuccessful login
                      print("Login failed");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                              message:
                                  "Login failed, \nCheck Email and password.");
                        },
                      );
                    }
                  } catch (error) {
                    // Handle errors from the API call or login process
                    print("Error during login: $error");
                    // Show the custom error dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(message: error.toString());
                      },
                    );
                  }
                },
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            //   Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const SignupScreen());
                },
                child: const Text(TTexts.createAccount),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
