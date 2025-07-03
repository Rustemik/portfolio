import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumePageVintage extends StatelessWidget {
  const ResumePageVintage({Key? key}) : super(key: key);

  static const backgroundColor = Color(0xFFF4EBD9);
  static const primaryColor = Color(0xFF5B4636);
  static const textColor = kBackgroundDarkColor22;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Основной контейнер с содержимым
              Container(
                color: backgroundColor,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('О себе:'),
                      const SizedBox(height: 8),
                      Text(
                        'Начинающий Flutter-разработчик, заинтересованный в создании качественных мобильных приложений с продуманной архитектурой и удобным пользовательским интерфейсом. Стремлюсь развиваться в командах с сильным техническим бэкграундом и участвовать в полном цикле разработки ПО.',
                        style: GoogleFonts.openSans(
                          color: textColor,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildSectionTitle('Навыки'),
                      const SizedBox(height: 16),
                      _buildSkillItem(
                        'BACK END',
                        'Знание основ серверной разработки, взаимодействие с REST API, обработка данных, работа с базами данных и асинхронным программированием в Dart.',
                      ),
                      const SizedBox(height: 12),
                      _buildSkillItem(
                        'FRONT END',
                        'Опыт создания адаптивных пользовательских интерфейсов на Flutter, работа с виджетами, кастомизацией UI, анимациями и использованием Google Fonts.',
                      ),
                      const SizedBox(height: 12),
                      _buildSkillItem(
                        'ARCHITECTURE',
                        'Понимание принципов проектирования приложений, разделение логики и UI, использование архитектурных паттернов (например, MVVM, Provider).',
                      ),
                      const SizedBox(height: 12),
                      _buildSkillItem(
                        'TEAM LEADING',
                        'Навыки коммуникации и совместной работы в команде, планирование задач и обмен знаниями.',
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _skillChip('Dart'),
                          _skillChip('Flutter'),
                          _skillChip('Provider'),
                          _skillChip('BLoC'),
                          _skillChip('REST API'),
                          _skillChip('Git'),
                          _skillChip('Firebase'),
                          _skillChip('Material Design'),
                          _skillChip('MVC / MVVM'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildSectionTitle('Опыт'),
                      const SizedBox(height: 8),
                      Text(
                        'Flutter проекты',
                        style: GoogleFonts.oswald(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildExperienceItem(
                        '- Разработка кроссплатформенного портфолио с адаптивным дизайном, использующим Responsive Framework и кастомные виджеты для отображения информации о навыках и процессах разработки.',
                      ),
                      _buildExperienceItem(
                        '- Создание компонентов UI с использованием Google Fonts и кастомных стилей, обеспечение удобной навигации и оптимизации под различные устройства (desktop, tablet, mobile).',
                      ),
                      _buildExperienceItem(
                        '- Интеграция изображений и иконок, организация сеток и адаптивных списков с помощью ResponsiveGridView.',
                      ),
                      _buildExperienceItem(
                        '- Работа с состоянием и взаимодействием пользователя (например, кнопки скачивания резюме с обработкой кликов).',
                      ),
                      const SizedBox(height: 32),
                      _buildSectionTitle('Образование'),
                      const SizedBox(height: 8),
                      _buildEducationItem(
                        'Название учебного заведения',
                        'Специальность',
                        'Годы обучения',
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Онлайн-курсы и самообучение:',
                        style: GoogleFonts.oswald(
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildBulletPoint(
                        '«Flutter & Dart – полное руководство» (Udemy / Coursera)',
                      ),
                      _buildBulletPoint(
                        'Официальная документация Flutter и Google Fonts',
                      ),
                      const SizedBox(height: 32),
                      _buildSectionTitle('Дополнительно'),
                      const SizedBox(height: 8),
                      _buildBulletPoint(
                        'Понимание основ UI/UX и адаптивного дизайна',
                      ),
                      _buildBulletPoint(
                        'Опыт работы с системами контроля версий (Git)',
                      ),
                      _buildBulletPoint(
                        'Быстрое освоение новых технологий и библиотек',
                      ),
                      _buildBulletPoint(
                        'Готовность к командной работе и обмену опытом',
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),

              // Болты в углах с разным поворотом для "закрученности"
              Positioned(
                top: 10,
                left: 10,
                child: const BoltWithCross(rotationDegrees: 10),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: const BoltWithCross(rotationDegrees: -15),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: const BoltWithCross(rotationDegrees: 25),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: const BoltWithCross(rotationDegrees: -5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.oswald(
        color: primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    );
  }

  Widget _buildSkillItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.oswald(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.openSans(
            color: textColor,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceItem(String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        description,
        style: GoogleFonts.openSans(
          color: textColor,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildEducationItem(
    String institution,
    String specialty,
    String years,
  ) {
    return Text(
      '- $institution — $specialty\n  $years',
      style: GoogleFonts.openSans(color: textColor, fontSize: 16, height: 1.5),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.openSans(
              color: textColor,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.openSans(
                color: textColor,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: primaryColor.withValues(alpha: 0.1),
      labelStyle: GoogleFonts.jetBrainsMono(color: backgroundColor),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    );
  }
}

// Виджет болта с крестовой прорезью, с возможностью поворота
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

    // Внешнее кольцо (чуть больше основного круга)
    final outerRadius = radius * 1.10;
    final ringPaint = Paint()
      ..color = Color.fromARGB(255, 67, 67, 67)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.15;
    canvas.drawCircle(center, outerRadius, ringPaint);

    // Рисуем тень
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.60)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    // Смещаем тень немного вниз и вправо
    final shadowOffset = Offset(3, 3);
    canvas.drawCircle(center + shadowOffset, radius, shadowPaint);

    final paintBolt = Paint()..color = boltColor;
    canvas.drawCircle(center, radius, paintBolt);

    final stripeThickness = size.height * 0.15;
    final stripeLength = size.width * 0.7;
    final paintStripe = Paint()..color = stripeColor;

    // Горизонтальная полоска (прорезь)
    final rectH = Rect.fromCenter(
      center: center,
      width: stripeLength,
      height: stripeThickness,
    );
    canvas.drawRect(rectH, paintStripe);

    // Вертикальная полоска (прорезь)
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









// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FlutterResume extends StatelessWidget {
//   const FlutterResume({Key? key}) : super(key: key);

//   static const primaryColor = Color(0xFF0D47A1);
//   static const backgroundColor = Color(0xFFF5F7FA);
//   static const sectionTitleColor = Color(0xFF0B3D91);
//   static const textColor = Colors.black87;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Иван Иванов',
//           style: GoogleFonts.roboto(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: primaryColor,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Flutter Developer | Junior Mobile Developer',
//           style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey[700]),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Icon(Icons.email, size: 18, color: Colors.grey[700]),
//             const SizedBox(width: 8),
//             Text('ivan.ivanov@example.com', style: _infoTextStyle),
//             const SizedBox(width: 24),
//             Icon(Icons.phone, size: 18, color: Colors.grey[700]),
//             const SizedBox(width: 8),
//             Text('+7 999 123 45 67', style: _infoTextStyle),
//           ],
//         ),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Обо мне'),
//         const SizedBox(height: 8),
//         Text(
//           'Мотивированный начинающий Flutter-разработчик с базовыми знаниями Dart и Flutter. '
//           'Имею опыт создания простых мобильных приложений с использованием современных архитектурных подходов и адаптивного дизайна. '
//           'Стремлюсь развиваться в области мобильной разработки и работать в команде профессионалов.',
//           style: _normalTextStyle,
//         ),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Навыки'),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 12,
//           runSpacing: 8,
//           children: [
//             _skillChip('Flutter'),
//             _skillChip('Dart'),
//             _skillChip('REST API'),
//             _skillChip('Git'),
//             _skillChip('Firebase'),
//             _skillChip('Provider'),
//             _skillChip('Material Design'),
//             _skillChip('JSON'),
//             _skillChip('MVC / MVVM'),
//           ],
//         ),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Опыт'),
//         const SizedBox(height: 12),
//         _buildExperience(
//           title: 'Проект: Приложение портфолио',
//           period: 'Январь 2023 – Май 2023',
//           description:
//               'Создал кроссплатформенное приложение на Flutter для демонстрации своих проектов и навыков. '
//               'Реализовал адаптивный UI, навигацию, интеграцию с Google Fonts и хранение данных локально.',
//         ),
//         _buildExperience(
//           title: 'Фриланс: Приложение для заметок',
//           period: 'Июнь 2023 – Август 2023',
//           description:
//               'Разработал простое приложение для создания и редактирования заметок с использованием Firebase для хранения данных. '
//               'Обеспечил синхронизацию и аутентификацию пользователей.',
//         ),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Образование'),
//         const SizedBox(height: 12),
//         _buildEducation(
//           institution: 'Московский государственный технический университет',
//           specialty: 'Информатика и вычислительная техника',
//           years: '2019 – 2023',
//         ),
//         _buildEducation(
//           institution: 'Онлайн-курсы по Flutter',
//           specialty: 'Udemy, Coursera',
//           years: '2022 – 2023',
//         ),
//         const SizedBox(height: 24),
//         _buildSectionTitle('Дополнительно'),
//         const SizedBox(height: 12),
//         _buildBullet('Знание английского языка – уровень B1'),
//         _buildBullet('Опыт работы с системами контроля версий (Git, GitHub)'),
//         _buildBullet('Быстрое освоение новых технологий'),
//         _buildBullet('Командная работа и коммуникабельность'),
//         const SizedBox(height: 32),
//       ],
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: GoogleFonts.roboto(
//         fontSize: 22,
//         fontWeight: FontWeight.bold,
//         color: sectionTitleColor,
//       ),
//     );
//   }

//   Widget _skillChip(String text) {
//     return Chip(
//       label: Text(text),
//       backgroundColor: primaryColor.withOpacity(0.1),
//       labelStyle: GoogleFonts.roboto(color: primaryColor),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//     );
//   }

//   Widget _buildExperience({
//     required String title,
//     required String period,
//     required String description,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//               color: primaryColor,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             period,
//             style: GoogleFonts.roboto(
//               fontStyle: FontStyle.italic,
//               fontSize: 14,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(description, style: _normalTextStyle),
//         ],
//       ),
//     );
//   }

//   Widget _buildEducation({
//     required String institution,
//     required String specialty,
//     required String years,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: RichText(
//         text: TextSpan(
//           style: GoogleFonts.roboto(fontSize: 16, color: textColor),
//           children: [
//             TextSpan(
//               text: institution,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextSpan(text: ' — $specialty\n'),
//             TextSpan(
//               text: years,
//               style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBullet(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('• ', style: TextStyle(fontSize: 20)),
//           Expanded(child: Text(text, style: _normalTextStyle)),
//         ],
//       ),
//     );
//   }

//   static final _normalTextStyle = GoogleFonts.roboto(
//     fontSize: 16,
//     height: 1.4,
//     color: textColor,
//   );

//   static final _infoTextStyle = GoogleFonts.roboto(
//     fontSize: 14,
//     color: Colors.grey,
//   );
// }


