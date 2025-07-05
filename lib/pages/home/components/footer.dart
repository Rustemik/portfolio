import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/gradient_icon.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  static const double breakpoint =
      600; // ширина экрана для переключения верстки

  @override
  Widget build(BuildContext context) {
    final color = kTitleTextDarkColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 2, color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > breakpoint) {
                // Desktop / Tablet layout — горизонтально
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _leftText(color),
                    _iconRow(color),
                    _rightText(color),
                  ],
                );
              } else {
                // Mobile layout — вертикально
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _leftText(color),
                    const SizedBox(height: 20),
                    _iconRow(color),
                    const SizedBox(height: 5),
                    _rightText(color),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _leftText(Color color) {
    return Text(
      "That's all folks!",
      style: GoogleFonts.jetBrainsMono(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _rightText(Color color) {
    return GestureDetector(
      onTap: () async {
        await launchUrlString('https://github.com/Rustemik/portfolio');
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          "portfolio made on flutter",
          style: GoogleFonts.jetBrainsMono(
            height: 1.5,
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _iconRow(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize.min,
      children: [
        _iconButton(
          icon: FontAwesomeIcons.telegram,
          url: 'https://t.me/hrust_116',
          color: color,
        ),
        const SizedBox(width: 20),
        _iconButton(
          icon: FontAwesomeIcons.github,
          url: 'https://github.com/Rustemik',
          color: color,
        ),
      ],
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return InkWell(
      onTap: () async {
        await launchUrlString(url);
      },
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}





// class Footer extends StatelessWidget {
//   const Footer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Divider(thickness: 2, color: Colors.white.withValues(alpha: 0.3)),
//           SizedBox(height: 10),
//           Stack(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "That's all folks!\n",
//                   style: GoogleFonts.jetBrainsMono(
//                     color: kTitleTextDarkColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 40,
//                       height: 40,
//                       child: InkWell(
//                         child: Icon(
//                           FontAwesomeIcons.telegram,
//                           color: kTitleTextDarkColor,
//                           size: 30,
//                         ),
//                         onTap: () async {
//                           await launchUrlString('https://t.me/hrust_116');
//                         },
//                       ),
//                     ),
//                     InkWell(
//                       child: SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: Icon(
//                           FontAwesomeIcons.github,
//                           color: kTitleTextDarkColor,
//                           size: 30,
//                         ),
//                       ),
//                       onTap: () async {
//                         await launchUrlString('https://github.com/Rustemik');
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: GestureDetector(
//                   onTap: () async {
//                     await launchUrlString(
//                       'https://github.com/Rustemik/portfolio',
//                     );
//                   },
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: Text(
//                       "portfolio made on flutter\n",
//                       style: GoogleFonts.jetBrainsMono(
//                         height: 1.5,
//                         color: kTitleTextDarkColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }






// InkWell(
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     child: Center(
                    //       child: Icon(
                    //         FontAwesomeIcons.youtube,
                    //         color: Colors.red,
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () async {
                    //     await launchUrlString(
                    //       'https://www.youtube.com/@deploychef',
                    //     );
                    //   },
                    // ),
                    // SizedBox(width: 5),
                    // InkWell(
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     child: Center(
                    //       child: Icon(
                    //         FontAwesomeIcons.telegram,
                    //         color: Color(0xff0088cc),
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () async {
                    //     await launchUrlString('https://t.me/hrust_116');
                    //   },
                    // ),
                    // SizedBox(width: 5),
                    // InkWell(
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     child: Center(
                    //       child: GradientIcon(
                    //         FontAwesomeIcons.instagram,
                    //         28,
                    //         LinearGradient(
                    //           colors: <Color>[
                    //             Color(0xff405de6),
                    //             Color(0xff833ab4),
                    //             Color(0xffe1306c),
                    //           ],
                    //           begin: Alignment.topLeft,
                    //           end: Alignment.bottomRight,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () async {
                    //     await launchUrlString(
                    //       'https://www.instagram.com/deploychef/',
                    //     );
                    //   },
                    // ),
                    //SizedBox(width: 5),
                    // InkWell(
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     child: Center(
                    //       child: Icon(
                    //         FontAwesomeIcons.linkedinIn,
                    //         color: Color(0xff0088cc),
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () async {
                    //     await launchUrlString(
                    //       'https://www.linkedin.com/in/vladislav-titov-7a68a517b/',
                    //     );
                    //   },
                    // ),
                    // SizedBox(width: 5),
                    // InkWell(
                    //   child: Container(
                    //     width: 32,
                    //     height: 32,
                    //     child: Center(
                    //       child: Icon(
                    //         FontAwesomeIcons.github,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    //   onTap: () async {
                    //     await launchUrlString('https://github.com/Rustemik');
                    //   },
                    // ),