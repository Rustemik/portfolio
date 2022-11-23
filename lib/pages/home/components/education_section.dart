import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/education.dart';
import 'package:portfolio/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

final List<Education> educationList = [
  Education(
    description:
        "Это образец образования, и подробности о нем указаны ниже - This is a sample education and details about it is stated below",
    LinkName: "www.flutterpanda.com",
    period: "2019 - PRESENT",
  ),
  Education(
    description:
        "Это образец образования, и подробности о нем указаны ниже - This is a sample education and details about it is stated below",
    LinkName: "www.flutterpanda.com",
    period: "2018 - 2019",
  ),
  Education(
    description:
        "Это образец образования, и подробности о нем указаны ниже - This is a sample education and details about it is stated below",
    LinkName: "www.flutterpanda.com",
    period: "2017 - 2018",
  ),
  Education(
    description:
        "Это образец образования, и подробности о нем указаны ниже - This is a sample education and details about it is stated below",
    LinkName: "www.flutterpanda.com",
    period: "2016 - 2017",
  ),
];

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(1000.0),
        tablet: _buildUi(800.0),
        mobile: _buildUi(MediaQuery.of(context).size.width * .8),
      ),
    );
  }

  Widget _buildUi(double width) {
    return Container(
      alignment: Alignment.center,
      child: ResponsiveWrapper(
        maxWidth: width,
        minWidth: width,
        defaultScale: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "EDUCATION",
              style: GoogleFonts.oswald(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                height: 1.3,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Wrap(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 400.0),
                  child: Text(
                    "A full stack all round developer that does all the job he needs to do at all times. Actually this is a false statement",
                    // Универсальный разработчик с полным стеком, который всегда выполняет всю работу, которую ему нужно делать. На самом деле это ложное утверждение
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
