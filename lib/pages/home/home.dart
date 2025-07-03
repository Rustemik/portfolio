import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/header_item.dart';
import 'package:portfolio/pages/home/components/carousel.dart';
import 'package:portfolio/pages/home/components/footer.dart';
import 'package:portfolio/pages/home/components/header.dart';
import 'package:portfolio/pages/home/components/projects_ad.dart';
import 'package:portfolio/pages/home/components/resume_page.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/globals.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<HeaderItem> headerItems;
  bool _showBackToTopButton = false;

  // Создаём ключи для разделов
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _summaryKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactsKey = GlobalKey();

  // Метод прокрутки к нужному разделу
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      // Получаем позицию виджета относительно Scrollable
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

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

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return headerItems[index].isButton
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kDangerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: headerItems[index].onTap,
                            child: Text(
                              headerItems[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListTile(
                        title: Text(
                          headerItems[index].title,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: headerItems[index].onTap,
                      );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: headerItems.length,
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child: Header(headerItems: headerItems)),
              Carousel(key: _homeKey),
              SizedBox(height: 10),
              Container(
                key: _projectsKey,
                child: _buildSectionTitle('PROJECTS:'),
              ),
              ProjectsAd(),
              SizedBox(height: 70),
              Container(
                key: _summaryKey,
                child: _buildSectionTitle('SUMMARY:'),
              ),
              ResumePageVintage(),
              SizedBox(height: 30),
              Container(key: _contactsKey, child: Footer()),
              //Stats(),
              //CvSection(),
              //WatchAd(),
              //SizedBox(height: 20),
              //UpnovaAd(),
              //SizedBox(height: 70),
              //WorkWith(),
              //SizedBox(height: 70),
              //VideoPage(),
            ],
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? Padding(
              padding: const EdgeInsets.only(bottom: 70, right: 30),
              child: SizedBox(
                width: 58,
                height: 58,
                child: Container(
                  //padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFF4EBD9), // цвет обводки
                      width: 2, // толщина обводки
                    ),
                  ),
                  child: FloatingActionButton(
                    onPressed: scrollToTop,
                    backgroundColor: Color(0xFF5B4636),
                    foregroundColor: Color(0xFFF4EBD9),
                    shape: CircleBorder(),
                    child: Icon(Icons.arrow_upward, size: 30),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.orbitron(
      color: Color(0xFFF4EBD9),
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    textAlign: TextAlign.center,
  );
}
