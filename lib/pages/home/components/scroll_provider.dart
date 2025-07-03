import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey summaryKey = GlobalKey();
  final GlobalKey contactsKey = GlobalKey();

  late List<HeaderItem> headerItems;

  late BuildContext _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void initHeaderItems(
    VoidCallback openDrawerCallback,
    Future<void> Function(String url) launchUrl,
  ) {
    headerItems = [
      HeaderItem(
        title: "HOME",
        onTap: () {
          openDrawerCallback();
          scrollToSection(homeKey);
        },
      ),
      HeaderItem(
        title: "PROJECTS",
        onTap: () {
          openDrawerCallback();
          scrollToSection(projectsKey);
        },
      ),
      HeaderItem(
        title: "SUMMARY",
        onTap: () {
          openDrawerCallback();
          scrollToSection(summaryKey);
        },
      ),
      HeaderItem(
        title: "CONTACTS",
        onTap: () {
          openDrawerCallback();
          scrollToSection(contactsKey);
        },
      ),
      HeaderItem(
        title: "HIRE ME",
        isButton: true,
        onTap: () async {
          openDrawerCallback();
          await launchUrl('https://t.me/hrust_116');
        },
      ),
    ];
    notifyListeners();
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

class HeaderItem {
  final String title;
  final bool isButton;
  final VoidCallback onTap;

  HeaderItem({required this.title, required this.onTap, this.isButton = false});
}
