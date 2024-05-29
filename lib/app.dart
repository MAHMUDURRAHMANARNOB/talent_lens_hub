import 'package:flutter/material.dart';
import 'package:talent_lens_hub/utils/theme/theme.dart';

//  -- Use This Class to setup themes, initial bindings or provider any animations and much more

class TalentLensHub extends StatelessWidget {
  const TalentLensHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
