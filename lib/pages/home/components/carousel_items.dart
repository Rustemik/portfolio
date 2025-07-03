import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/carousel_item_model.dart';
import 'package:portfolio/pages/home/components/clock.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

List<CarouselItemModel> getCarouselItems(ThemeData theme) => [
  CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // Обводка
              Text(
                "Flutter Developer",
                style: GoogleFonts.orbitron(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = kTitleTextDarkColor, // цвет обводки
                ),
              ),
              // Заливка
              Text(
                "Flutter Developer",
                style: GoogleFonts.orbitron(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: theme.primaryColor, // цвет заливки букв
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Text(
            "Hi, my name is\nRustem", //RUSTEM\nSHAYAKBIROV
            style: GoogleFonts.orbitron(
              color: kTitleTextDarkColor,
              fontSize: 50,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(height: 25),
          Text(
            "Flutter Developer, based on Kazan",
            //style: theme.textTheme.bodyLarge,
            style: GoogleFonts.jetBrainsMono(height: 1.5, fontSize: 18),
          ),
          SizedBox(height: 10),
          Container(
            child: Wrap(
              children: [
                Text(
                  "Any questions? ",
                  style: GoogleFonts.jetBrainsMono(
                    // style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await launchUrlString('https://t.me/hrust_116');
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Lets talk.",
                      style: GoogleFonts.jetBrainsMono(
                        height: 1.5,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          // MouseRegion(
          //   cursor: SystemMouseCursors.click,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: kPrimaryColor,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     height: 48,
          //     child: TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         "GET STARTED",
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 13,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    ),
    image: Container(
      child:
          ClockSwitcher(), //Image.asset("assets/person.png", fit: BoxFit.contain),
    ),
  ),
];
