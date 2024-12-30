import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:talent_lens_hub/utils/constants/sizes.dart';

import '../../../../utils/helpers/helper_function.dart';
import '../../../ToolsContent/screens/ToolsContentScreen.dart';

class AiHelperContainer extends StatelessWidget {
  const AiHelperContainer({
    super.key,
    required this.image,
    required this.title,
    required this.color,
    required this.toolsName,
  });

  final String title;
  final String image;
  final Color color;
  final String toolsName;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        print('$title pressed');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ToolsContentScreen(toolsName: toolsName)),
        );
      },
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        margin: const EdgeInsets.all(5.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: dark ? Colors.white : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Text(
              title,
              // maxLines: 2,
              style: TextStyle(
                  /*color: Colors.grey.shade900,*/
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
