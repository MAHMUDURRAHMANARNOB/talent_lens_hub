import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../ToolsContent/screens/ToolsContentScreen.dart';

class PDContainer extends StatelessWidget {
  const PDContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.bgColor,
    required this.toolsName,
  });

  final IconData icon;
  final String title;
  final String toolsName;
  final Color bgColor;

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
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        // height: 150,
        decoration: BoxDecoration(
          color: /*dark ? TColors.dark : TColors.light*/
              bgColor,
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*Expanded(
              child: Image.asset(
                image,
                height: 100,
                width: 40,
              ),
            ),*/
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(64.0),
              ),
              child: Icon(
                icon,
                color: bgColor,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                child: Text(
                  textAlign: TextAlign.start,
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
