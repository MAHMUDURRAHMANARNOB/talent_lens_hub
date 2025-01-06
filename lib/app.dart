import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_lens_hub/features/authentication/screens/onBoarding/onboarding.dart';
import 'package:talent_lens_hub/navigation_menu.dart';
import 'package:talent_lens_hub/utils/constants/colors.dart';
import 'package:talent_lens_hub/utils/theme/theme.dart';

import 'features/authentication/providers/auth_provider.dart';

//  -- Use This Class to setup themes, initial bindings or provider any animations and much more

class TalentLensHub extends StatelessWidget {
  const TalentLensHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.lightTheme,
      home: const OnBoardingScreen(),
    );
  }
}
