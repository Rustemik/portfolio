import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pages/home/components/summary_page.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class BoltWithCross extends StatelessWidget {
  final double size;
  final Color boltColor;
  final Color stripeColor;
  final double rotationDegrees;

  const BoltWithCross({
    Key? key,
    this.size = 17,
    this.boltColor = const Color.fromARGB(255, 20, 20, 20),
    this.stripeColor = const Color.fromARGB(255, 67, 67, 67),
    this.rotationDegrees = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationDegrees * 3.1415926535 / 180,
      child: CustomPaint(
        size: Size(size, size),
        painter: _BoltCrossPainter(boltColor, stripeColor),
      ),
    );
  }
}

class _BoltCrossPainter extends CustomPainter {
  final Color boltColor;
  final Color stripeColor;

  _BoltCrossPainter(this.boltColor, this.stripeColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final outerRadius = radius * 1.10;
    final ringPaint = Paint()
      ..color = const Color.fromARGB(255, 67, 67, 67)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.15;
    canvas.drawCircle(center, outerRadius, ringPaint);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final shadowOffset = const Offset(3, 3);
    canvas.drawCircle(center + shadowOffset, radius, shadowPaint);

    final paintBolt = Paint()..color = boltColor;
    canvas.drawCircle(center, radius, paintBolt);

    final stripeThickness = size.height * 0.15;
    final stripeLength = size.width * 0.7;
    final paintStripe = Paint()..color = stripeColor;

    final rectH = Rect.fromCenter(
      center: center,
      width: stripeLength,
      height: stripeThickness,
    );
    canvas.drawRect(rectH, paintStripe);

    final rectV = Rect.fromCenter(
      center: center,
      width: stripeThickness,
      height: stripeLength,
    );
    canvas.drawRect(rectV, paintStripe);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Project {
  final List<String> images;
  final String title;
  final String description;
  final String githubUrl;

  Project({
    required this.images,
    required this.title,
    required this.description,
    required this.githubUrl,
  });
}

class AdaptiveImage extends StatefulWidget {
  final String assetPath;
  final BoxFit fit;

  const AdaptiveImage({
    Key? key,
    required this.assetPath,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  State<AdaptiveImage> createState() => _AdaptiveImageState();
}

class _AdaptiveImageState extends State<AdaptiveImage> {
  ui.Image? _image;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await rootBundle.load(widget.assetPath);
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();

    if (!mounted) return;

    setState(() {
      _image = frame.image;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        final imgWidth = _image!.width.toDouble();
        final imgHeight = _image!.height.toDouble();

        final imgAspectRatio = imgWidth / imgHeight;
        final containerAspectRatio = maxWidth / maxHeight;

        double displayWidth;
        double displayHeight;

        if (containerAspectRatio > imgAspectRatio) {
          displayHeight = maxHeight;
          displayWidth = displayHeight * imgAspectRatio;
        } else {
          displayWidth = maxWidth;
          displayHeight = displayWidth / imgAspectRatio;
        }

        return SizedBox(
          width: displayWidth,
          height: displayHeight,
          child: Image.asset(widget.assetPath, fit: widget.fit),
        );
      },
    );
  }
}

class ProjectsAd extends StatefulWidget {
  const ProjectsAd({Key? key}) : super(key: key);

  @override
  State<ProjectsAd> createState() => _ProjectsAdState();
}

class _ProjectsAdState extends State<ProjectsAd> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Project> projects = [
    Project(
      images: [
        'assets/image/magic_lama_1.png',
        'assets/image/magic_lama_2.png',
        'assets/image/magic_lama_3.png',
      ],
      title: 'MAGIC LAMA APP',
      description:
          'Random textRandom textRandom textRandom textRandom textRandom textRandom textRandom textRandom textRandom text',
      githubUrl: 'https://github.com/yourgithub/project1',
    ),
    Project(
      images: [
        'assets/image/authorization_1.png',
        'assets/image/authorization_2.png',
        'assets/image/authorization_3.png',
        'assets/image/authorization_4.png',
        'assets/image/authorization_5.png',
      ],
      title: 'AUTHORIZATION APP',
      description:
          'This is another project description. It explains the features and benefits of the fitness tracker app in detail.',
      githubUrl: 'https://github.com/yourgithub/project2',
    ),
    Project(
      images: [
        'assets/image/cinemafilter_1.png',
        'assets/image/cinemafilter_2.png',
        'assets/image/cinemafilter_3.png',
        'assets/image/cinemafilter_4.png',
        'assets/image/cinemafilter_5.png',
        'assets/image/cinemafilter_6.png',
        'assets/image/cinemafilter_7.png',
        'assets/image/cinemafilter_8.png',
        'assets/image/cinemafilter_9.png',
        'assets/image/cinemafilter_10.png',
      ],
      title: 'CINEMA FILTER APP',
      description:
          'This is another project description. It explains the features and benefits of the fitness tracker app in detail.',
      githubUrl: 'https://github.com/yourgithub/project2',
    ),
    Project(
      images: [
        'assets/image/bubble_sort_1.png',
        'assets/image/bubble_sort_2.png',
        'assets/image/bubble_sort_3.png',
        'assets/image/bubble_sort_4.png',
      ],
      title: 'BUBBLE SORT APP',
      description:
          'This is another project description. It explains the features and benefits of the fitness tracker app in detail.',
      githubUrl: 'https://github.com/yourgithub/project2',
    ),
  ];

  int _currentProjectIndex = 0;

  void _launchGitHub() async {
    final url = projects[_currentProjectIndex].githubUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch GitHub URL')),
      );
    }
  }

  void _goToPreviousProject() {
    if (_currentProjectIndex > 0) {
      setState(() {
        _currentProjectIndex--;
        _currentPage = 0;
        _pageController.jumpToPage(0);
      });
    }
  }

  void _goToNextProject() {
    if (_currentProjectIndex < projects.length - 1) {
      setState(() {
        _currentProjectIndex++;
        _currentPage = 0;
        _pageController.jumpToPage(0);
      });
    }
  }

  void _goToPreviousImage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextImage() {
    if (_currentPage < projects[_currentProjectIndex].images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _styledButton({
    required Widget icon,
    required VoidCallback? onPressed,
    String? tooltip,
    double size = 40,
  }) {
    final bool enabled = onPressed != null;
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: enabled ? SummaryPage.primaryColor : Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: SummaryPage.primaryColor.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
            border: Border.all(color: kTitleTextDarkColor, width: 1.5),
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(
                color: enabled
                    ? SummaryPage.backgroundColor
                    : kTitleTextDarkColor,
                size: size * 0.6,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentProject = projects[_currentProjectIndex];
    final bgColor = SummaryPage.backgroundColor;
    final textColor = SummaryPage.textColor;
    final primaryColor = SummaryPage.primaryColor;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: bgColor,
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                  minWidth: 300,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWide = constraints.maxWidth > 720;

                          if (isWide) {
                            // Широкий экран — горизонтальная верстка
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Картинка с кнопками переключения фото
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: SizedBox(
                                    width: 271,
                                    height: 400,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _styledButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: _currentPage > 0
                                              ? _goToPreviousImage
                                              : null,
                                          tooltip: 'Previous Photo',
                                          size: 32,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: PageView.builder(
                                              controller: _pageController,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  currentProject.images.length,
                                              onPageChanged: (index) {
                                                setState(() {
                                                  _currentPage = index;
                                                });
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  color: Colors.black,
                                                  alignment: Alignment.center,
                                                  child: AdaptiveImage(
                                                    assetPath: currentProject
                                                        .images[index],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        _styledButton(
                                          icon: const Icon(Icons.arrow_forward),
                                          onPressed:
                                              _currentPage <
                                                  currentProject.images.length -
                                                      1
                                              ? _goToNextImage
                                              : null,
                                          tooltip: 'Next Photo',
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 40),

                                // Текст и кнопки переключения проектов
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        currentProject.title,
                                        style: GoogleFonts.shareTechMono(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w900,
                                          height: 1.3,
                                          fontSize: 35,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        currentProject.description,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 16,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: _launchGitHub,
                                            child: Text(
                                              'GIT HUB',
                                              style: GoogleFonts.shareTechMono(
                                                color: bgColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          _styledButton(
                                            icon: const Icon(Icons.arrow_back),
                                            onPressed: _currentProjectIndex > 0
                                                ? _goToPreviousProject
                                                : null,
                                            tooltip: 'Previous Project',
                                            size: 40,
                                          ),
                                          const SizedBox(width: 12),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              side: BorderSide(
                                                color: primaryColor,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 16,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed:
                                                _currentProjectIndex <
                                                    projects.length - 1
                                                ? _goToNextProject
                                                : null,
                                            child: Text(
                                              'NEXT APP',
                                              style: GoogleFonts.shareTechMono(
                                                color:
                                                    _currentProjectIndex <
                                                        projects.length - 1
                                                    ? primaryColor
                                                    : Colors.grey.shade500,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Узкий экран — вертикальная верстка
                            // Вместо текущей верстки для узких экранов
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 271,
                                  height: 400,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _styledButton(
                                        icon: const Icon(Icons.arrow_back),
                                        onPressed: _currentPage > 0
                                            ? _goToPreviousImage
                                            : null,
                                        tooltip: 'Previous Photo',
                                        size: 32,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: PageView.builder(
                                            controller: _pageController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                currentProject.images.length,
                                            onPageChanged: (index) {
                                              setState(() {
                                                _currentPage = index;
                                              });
                                            },
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: Colors.black,
                                                alignment: Alignment.center,
                                                child: AdaptiveImage(
                                                  assetPath: currentProject
                                                      .images[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      _styledButton(
                                        icon: const Icon(Icons.arrow_forward),
                                        onPressed:
                                            _currentPage <
                                                currentProject.images.length - 1
                                            ? _goToNextImage
                                            : null,
                                        tooltip: 'Next Photo',
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Text(
                                  currentProject.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.shareTechMono(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w900,
                                    height: 1.3,
                                    fontSize: 28,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                Text(
                                  currentProject.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      onPressed: _launchGitHub,
                                      child: Text(
                                        'GIT HUB',
                                        style: GoogleFonts.shareTechMono(
                                          color: bgColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    _styledButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: _currentProjectIndex > 0
                                          ? _goToPreviousProject
                                          : null,
                                      tooltip: 'Previous Project',
                                      size: 40,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        side: BorderSide(color: primaryColor),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          _currentProjectIndex <
                                              projects.length - 1
                                          ? _goToNextProject
                                          : null,
                                      child: Text(
                                        'NEXT APP',
                                        style: GoogleFonts.shareTechMono(
                                          color:
                                              _currentProjectIndex <
                                                  projects.length - 1
                                              ? primaryColor
                                              : Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Болты в углах
              const Positioned(
                top: 10,
                left: 10,
                child: BoltWithCross(rotationDegrees: 10),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: BoltWithCross(rotationDegrees: -15),
              ),
              const Positioned(
                bottom: 10,
                left: 10,
                child: BoltWithCross(rotationDegrees: 25),
              ),
              const Positioned(
                bottom: 10,
                right: 10,
                child: BoltWithCross(rotationDegrees: -5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
