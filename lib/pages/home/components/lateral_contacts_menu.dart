import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LateralContactsMenu extends StatelessWidget {
  const LateralContactsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kTitleTextDarkColor,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.telegram,
                        color: kBackgroundDarkColor,
                        size: 40,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await launchUrlString('https://t.me/hrust_116');
                  },
                ),
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.github,
                        color: kBackgroundDarkColor,
                        size: 40,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await launchUrlString('https://github.com/Rustemik');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
