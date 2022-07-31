import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/header_item.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/globals.dart';
import 'package:portfolio/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

List<HeaderItem> headerItems = [
  HeaderItem(title: "HOME", onTap: () {}),
  HeaderItem(title: "MY INTRO", onTap: () {}),
  HeaderItem(title: "SERVICES", onTap: () {}),
  HeaderItem(title: "PORTFOLIO", onTap: () {}),
  HeaderItem(title: "TESTIMONIALS", onTap: () {}),
  HeaderItem(title: "BLOGS", onTap: () {}),
  HeaderItem(
    title: "HIRE ME",
    onTap: () {},
    isButton: true,
  ),
];

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "h",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "Rust",
                  style: GoogleFonts.oswald(
                    color: kPrimaryColor,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: [
        Condition.largerThan(name: "MOBILE"),
      ],
      child: Row(
        children: headerItems
            .map((item) => item.isButton
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kDangerColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: item.onTap,
                      ),
                    ),
                  )
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: GestureDetector(
                        onTap: item.onTap,
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ))
            .toList(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: buildHeader(),
        ),
        //Cделаем это немного позже - We will make this in a bit
        mobile: buildMobileHeader(),
        tablet: buildHeader(),
      ),
    );
  }

  //mobile header
  Widget buildMobileHeader() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HeaderLogo(),
            //Перезагрузите сервер, чтобы значки заработали - Restart server to make icons work
            //Cоздадим ключ для каркаса и создадим ящик (globals.dart) - Lets make a scaffold key and create a drawer
            GestureDetector(
              onTap: () {
                //Откроем ящик с помощью глобального ключа - Lets open drawer using global key
                Globals.scaffoldKey.currentState?.openEndDrawer();
              },
              child: Icon(
                FlutterIcons.menu_fea,
                color: Colors.white,
                size: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Позволяет планировать для мобильных устройств и экрана меньшей ширины - Lets plan for mobile and smaller width screen
  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderLogo(),
          HeaderRow(),
        ],
      ),
    );
  }
}
