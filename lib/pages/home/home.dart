import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/header_item.dart';
import 'package:portfolio/pages/home/components/carousel.dart';
import 'package:portfolio/pages/home/components/clock.dart';
import 'package:portfolio/pages/home/components/footer.dart';
import 'package:portfolio/pages/home/components/header.dart';
import 'package:portfolio/pages/home/components/projects_ad.dart';
import 'package:portfolio/pages/home/components/lateral_contacts_menu.dart';
import 'package:portfolio/pages/home/components/summary_page.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/globals.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<HeaderItem> headerItems;
  bool _showBackToTopButton = false;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _summaryKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactsKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= 200) {
        if (!_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = true;
          });
        }
      } else {
        if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false;
          });
        }
      }
    });

    headerItems = [
      HeaderItem(title: "HOME", onTap: () => _scrollToSection(_homeKey)),
      HeaderItem(title: "SUMMARY", onTap: () => _scrollToSection(_summaryKey)),
      HeaderItem(
        title: "PROJECTS",
        onTap: () => _scrollToSection(_projectsKey),
      ),
      HeaderItem(
        title: "CONTACTS",
        onTap: () => _scrollToSection(_contactsKey),
      ),
      HeaderItem(
        title: "HIRE ME",
        isButton: true,
        onTap: () async {
          await launchUrlString('https://t.me/hrust_116');
        },
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 720;

    return Scaffold(
      key: Globals.scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = headerItems[index];
                if (item.isButton) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kTitleTextDarkColor,
                          width: 2,
                        ),
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: item.onTap,
                        child: Text(
                          item.title,
                          style: GoogleFonts.shareTechMono(
                            color: kTitleTextDarkColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text(
                      item.title,
                      style: GoogleFonts.shareTechMono(
                        color: kTitleTextDarkColor,
                      ),
                    ),
                    onTap: item.onTap,
                  );
                }
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: headerItems.length,
            ),
          ),
        ),
      ),
      drawer: const LateralContactsMenu(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Header(headerItems: headerItems),

                // Карусель с параметром showClock
                Carousel(key: _homeKey, showClock: isWideScreen),

                const SizedBox(height: 20),

                // При узком экране показываем часы отдельно под каруселью
                if (!isWideScreen) const ClockSwitcher(),
                const SizedBox(height: 50),
                Container(
                  key: _summaryKey,
                  child: _buildSectionTitle('SUMMARY:'),
                ),
                const SummaryPage(),
                const SizedBox(height: 10),
                Container(
                  child: LottieBuilder.asset(
                    'assets/json/animation.json',
                    width: 400,
                    height: 400,
                  ),
                ),
                Container(
                  key: _projectsKey,
                  child: _buildSectionTitle('PROJECTS:'),
                ),
                const ProjectsAd(),
                const SizedBox(height: 10),
                Container(key: _contactsKey, child: const Footer()),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 5,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 35,
                    color: kTitleTextDarkColor,
                  ),
                  onPressed: () {
                    Globals.scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTopButton
          ? Padding(
              padding: const EdgeInsets.only(bottom: 70, right: 30),
              child: SizedBox(
                width: 58,
                height: 58,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kTitleTextDarkColor, width: 2),
                  ),
                  child: FloatingActionButton(
                    onPressed: scrollToTop,
                    backgroundColor: kSecondaryColor,
                    foregroundColor: kTitleTextDarkColor,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_upward, size: 30),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.shareTechMono(
      color: kTitleTextDarkColor,
      fontWeight: FontWeight.w700,
      fontSize: 35,
    ),
    textAlign: TextAlign.center,
  );
}

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late List<HeaderItem> headerItems;
//   bool _showBackToTopButton = false;

//   // Создаём ключи для разделов
//   final GlobalKey _homeKey = GlobalKey();
//   final GlobalKey _summaryKey = GlobalKey();
//   final GlobalKey _projectsKey = GlobalKey();
//   final GlobalKey _contactsKey = GlobalKey();

//   // Метод прокрутки к нужному разделу
//   void _scrollToSection(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       // Получаем позицию виджета относительно Scrollable
//       Scrollable.ensureVisible(
//         context,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       if (_scrollController.offset >= 200) {
//         if (!_showBackToTopButton) {
//           setState(() {
//             _showBackToTopButton = true;
//           });
//         }
//       } else {
//         if (_showBackToTopButton) {
//           setState(() {
//             _showBackToTopButton = false;
//           });
//         }
//       }
//     });
//     headerItems = [
//       HeaderItem(title: "HOME", onTap: () => _scrollToSection(_homeKey)),
//       HeaderItem(title: "SUMMARY", onTap: () => _scrollToSection(_summaryKey)),
//       HeaderItem(
//         title: "PROJECTS",
//         onTap: () => _scrollToSection(_projectsKey),
//       ),
//       HeaderItem(
//         title: "CONTACTS",
//         onTap: () => _scrollToSection(_contactsKey),
//       ),
//       HeaderItem(
//         title: "HIRE ME",
//         isButton: true,
//         onTap: () async {
//           await launchUrlString('https://t.me/');
//         },
//       ),
//     ];
//   }

//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void scrollToTop() {
//     _scrollController.animateTo(
//       0,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: Globals.scaffoldKey,
//       endDrawer: Drawer(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//             child: ListView.separated(
//               itemBuilder: (context, index) {
//                 return headerItems[index].isButton
//                     ? MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: kTitleTextDarkColor, // цвет обводки
//                               width: 2, // толщина обводки
//                             ),
//                             color: kSecondaryColor,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: TextButton(
//                             onPressed: headerItems[index].onTap,
//                             child: Text(
//                               headerItems[index].title,
//                               style: GoogleFonts.shareTechMono(
//                                 color: kTitleTextDarkColor,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     : ListTile(
//                         title: Text(
//                           headerItems[index].title,
//                           style: GoogleFonts.shareTechMono(
//                             color: kTitleTextDarkColor,
//                           ),
//                         ),
//                         onTap: headerItems[index].onTap,
//                       );
//               },
//               separatorBuilder: (context, index) {
//                 return SizedBox(height: 10);
//               },
//               itemCount: headerItems.length,
//             ),
//           ),
//         ),
//       ),
//       drawer: LateralContactsMenu(),
//       body: Container(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(child: Header(headerItems: headerItems)),
//                   Carousel(key: _homeKey),
//                   SizedBox(height: 10),
//                   // ClockSwitcher(),
//                   // SizedBox(height: 10),
//                   Container(
//                     key: _projectsKey,
//                     child: _buildSectionTitle('PROJECTS:'),
//                   ),
//                   ProjectsAd(),
//                   SizedBox(height: 70),
//                   Container(
//                     key: _summaryKey,
//                     child: _buildSectionTitle('SUMMARY:'),
//                   ),
//                   SummaryPage(),
//                   SizedBox(height: 30),
//                   Container(key: _contactsKey, child: Footer()),
//                   //Stats(),
//                   //CvSection(),
//                   //WatchAd(),
//                   //SizedBox(height: 20),
//                   //UpnovaAd(),
//                   //SizedBox(height: 70),
//                   //WorkWith(),
//                   //SizedBox(height: 70),
//                   //VideoPage(),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 50, // отступ сверху
//               left: 5, // отступ слева
//               child: SafeArea(
//                 child: Material(
//                   color: Colors.transparent,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.account_circle,
//                       size: 35,
//                       color: kTitleTextDarkColor,
//                     ),
//                     onPressed: () {
//                       Globals.scaffoldKey.currentState?.openDrawer();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: _showBackToTopButton
//           ? Padding(
//               padding: const EdgeInsets.only(bottom: 70, right: 30),
//               child: SizedBox(
//                 width: 58,
//                 height: 58,
//                 child: Container(
//                   //padding: const EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: kTitleTextDarkColor, // цвет обводки
//                       width: 2, // толщина обводки
//                     ),
//                   ),
//                   child: FloatingActionButton(
//                     onPressed: scrollToTop,
//                     backgroundColor: kSecondaryColor,
//                     foregroundColor: kTitleTextDarkColor,
//                     shape: CircleBorder(),
//                     child: Icon(Icons.arrow_upward, size: 30),
//                   ),
//                 ),
//               ),
//             )
//           : null,
//     );
//   }

//   void scrollToSection(GlobalKey key) {
//     final context = key.currentContext;
//     if (context != null) {
//       Scrollable.ensureVisible(
//         context,
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
// }

// Widget _buildSectionTitle(String title) {
//   return Text(
//     title,
//     style: GoogleFonts.shareTechMono(
//       color: kTitleTextDarkColor,
//       fontWeight: FontWeight.w700,
//       fontSize: 35,
//     ),
//     textAlign: TextAlign.center,
//   );
// }
