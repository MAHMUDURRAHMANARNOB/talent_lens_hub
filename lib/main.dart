import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_lens_hub/utils/theme/theme.dart';

import 'app.dart';
import 'features/ToolsContent/providers/studyToolsProvider.dart';
import 'features/ToolsContent/providers/toolsDataByCodeProvider.dart';
import 'features/ToolsContent/providers/toolsReplyProvider.dart';
import 'features/ToolsContent/providers/toolsResponseProvider.dart';

// ---- Entry Point of Flutter App ----
void main() {
  // TODO: Add Widget Binding / Multi-Providers
  // TODO: init Local Storage
  // TODO: Await Native Splash
  // TODO: Initialize FireBase
  // TODO: Initialize Authentication

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => StudyToolsProvider(userId: 0)),
        ChangeNotifierProvider(
          create: (context) => ToolsDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToolsResponseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ToolsReplyProvider(),
        ),
      ],
      child: TalentLensHub(),
    ),
  );
}
