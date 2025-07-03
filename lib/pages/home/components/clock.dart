import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF4EBD9),
      body: SafeArea(child: Center(child: DaVinciClockSwitcher())),
    ),
  ),
);

class DaVinciClockSwitcher extends StatefulWidget {
  const DaVinciClockSwitcher({super.key});

  @override
  State<DaVinciClockSwitcher> createState() => _DaVinciClockSwitcherState();
}

class _DaVinciClockSwitcherState extends State<DaVinciClockSwitcher> {
  bool _showAnalog = true;

  @override
  Widget build(BuildContext context) {
    final size = math.min(MediaQuery.of(context).size.width, 320.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: _showAnalog
              ? DaVinciAnalogClock(size: size)
              : DaVinciDigitalClock(size: size),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5B4636),
            foregroundColor: const Color(0xFFF4EBD9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            setState(() {
              _showAnalog = !_showAnalog;
            });
          },
          child: Text(
            _showAnalog ? 'digital' : 'analog',
            style: _showAnalog
                ? GoogleFonts.orbitron(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF4EBD9),
                  )
                : GoogleFonts.shareTechMono(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF4EBD9),
                  ),
          ),
        ),
      ],
    );
  }
}

class DaVinciAnalogClock extends StatefulWidget {
  final double size;

  const DaVinciAnalogClock({super.key, required this.size});

  @override
  State<DaVinciAnalogClock> createState() => _DaVinciAnalogClockState();
}

class _DaVinciAnalogClockState extends State<DaVinciAnalogClock> {
  late Timer _timer;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _dateTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final radius = widget.size / 2 * 0.9;

    final logoOffset = Offset(center.dx, center.dy - radius / 4);

    return Stack(
      children: [
        CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _DaVinciClockPainter(_dateTime),
        ),
        Positioned(
          left: logoOffset.dx - widget.size * 0.07,
          top: logoOffset.dy - widget.size * 0.07,
          width: widget.size * 0.14,
          height: widget.size * 0.14,
          child: Icon(
            Icons.flutter_dash,
            color: const Color(0xFF5B4636),
            size: widget.size * 0.14,
          ),
        ),
      ],
    );
  }
}

class _DaVinciClockPainter extends CustomPainter {
  final DateTime dateTime;

  _DaVinciClockPainter(this.dateTime);

  final Color paperColor = const Color(0xFFF4EBD9);
  final Color lineColor = const Color(0xFF5B4636);
  final Color shadowColor = const Color(0xFF3A2F24);

  final double strokeWidth = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.9;

    final backgroundPaint = Paint()
      ..color = paperColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    final dialPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, dialPaint);
    canvas.drawCircle(center, radius * 0.85, dialPaint);

    final raysPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.3)
      ..strokeWidth = 0.8;

    for (int i = 0; i < 12; i++) {
      final angle = 2 * math.pi * i / 12 - math.pi / 2;
      final p1 = Offset(
        center.dx + radius * 0.85 * math.cos(angle),
        center.dy + radius * 0.85 * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + radius * 0.95 * math.cos(angle),
        center.dy + radius * 0.95 * math.sin(angle),
      );
      canvas.drawLine(p1, p2, raysPaint);
    }

    final tickPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 12; i++) {
      final angle = 2 * math.pi * i / 12 - math.pi / 2;
      final p1 = Offset(
        center.dx + radius * 0.7 * math.cos(angle),
        center.dy + radius * 0.7 * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + radius * 0.85 * math.cos(angle),
        center.dy + radius * 0.85 * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    final minuteTickPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 60; i++) {
      if (i % 5 == 0) continue;
      final angle = 2 * math.pi * i / 60 - math.pi / 2;
      final p1 = Offset(
        center.dx + radius * 0.78 * math.cos(angle),
        center.dy + radius * 0.78 * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + radius * 0.85 * math.cos(angle),
        center.dy + radius * 0.85 * math.sin(angle),
      );
      canvas.drawLine(p1, p2, minuteTickPaint);
    }

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final numberTextStyle = GoogleFonts.shareTechMono(
      color: lineColor,
      fontSize: radius * 0.12,
      //fontFamily: 'PatrickHand',
      fontWeight: FontWeight.w400,
      shadows: [
        Shadow(
          offset: const Offset(0.5, 0.5),
          color: shadowColor.withValues(alpha: 0.3),
          blurRadius: 1,
        ),
      ],
    );

    for (int i = 1; i <= 12; i++) {
      final angle = 2 * math.pi * i / 12 - math.pi / 2;
      final text = TextSpan(text: '$i', style: numberTextStyle);
      textPainter.text = text;
      textPainter.layout();

      final offset = Offset(
        center.dx + radius * 0.58 * math.cos(angle) - textPainter.width / 2,
        center.dy + radius * 0.58 * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }

    final ms = dateTime.millisecond / 1000;
    final sec = dateTime.second + ms;
    final min = dateTime.minute + sec / 60;
    final hour = (dateTime.hour % 12) + min / 60;

    final hourAngle = (hour * 30) * math.pi / 180 - math.pi / 2;
    final minuteAngle = (min * 6) * math.pi / 180 - math.pi / 2;
    final secondAngle = (sec * 6) * math.pi / 180 - math.pi / 2;

    final hourHandLength = radius * 0.45;
    final hourHandPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final hourHandEnd = Offset(
      center.dx + hourHandLength * math.cos(hourAngle),
      center.dy + hourHandLength * math.sin(hourAngle),
    );
    canvas.drawLine(center, hourHandEnd, hourHandPaint);

    final minuteHandLength = radius * 0.7;
    final minuteHandPaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final minuteHandEnd = Offset(
      center.dx + minuteHandLength * math.cos(minuteAngle),
      center.dy + minuteHandLength * math.sin(minuteAngle),
    );
    canvas.drawLine(center, minuteHandEnd, minuteHandPaint);

    final secondHandLength = radius * 0.75;
    final secondHandPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.7)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    final secondHandEnd = Offset(
      center.dx + secondHandLength * math.cos(secondAngle),
      center.dy + secondHandLength * math.sin(secondAngle),
    );
    canvas.drawLine(center, secondHandEnd, secondHandPaint);

    final centerDotRadius = 6.0;
    final centerDotPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
    canvas.drawCircle(center, centerDotRadius, centerDotPaint);

    final decoPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double r = radius * 0.95; r > radius * 0.5; r -= radius * 0.15) {
      canvas.drawCircle(center, r, decoPaint);
    }

    // Верхний текст "Analog watch" по дуге
    const String topText = 'Analog watch';
    final double topTextRadius = radius * 1.15;
    final int topCharCount = topText.length;
    final double topArcAngle = math.pi / 2; // 90°
    final double topStartAngle = -math.pi / 2 - topArcAngle / 2;

    for (int i = 0; i < topCharCount; i++) {
      final String char = topText[i];
      final double charAngle =
          topStartAngle + i * (topArcAngle / (topCharCount - 1));

      final Offset charOffset = Offset(
        center.dx + topTextRadius * math.cos(charAngle),
        center.dy + topTextRadius * math.sin(charAngle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: char,
          style: GoogleFonts.shareTechMono(
            fontSize: radius * 0.11,
            color: paperColor,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                color: lineColor.withValues(alpha: 0.8),
                blurRadius: 2,
              ),
              Shadow(
                offset: const Offset(-1, -1),
                color: lineColor.withValues(alpha: 0.8),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      canvas.save();
      canvas.translate(charOffset.dx, charOffset.dy);
      canvas.rotate(charAngle + math.pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Нижний текст "this watch app is written in flutter" по дуге
    const String bottomText = 'this watch app is written in flutter';
    final double bottomTextRadius = radius * 1.1;
    final int bottomCharCount = bottomText.length;
    final double bottomArcAngle = math.pi / 2; // 90°
    final double bottomStartAngle = math.pi / 2 - bottomArcAngle / 2;

    for (int i = 0; i < bottomCharCount; i++) {
      final String char = bottomText[bottomCharCount - 1 - i];
      final double charAngle =
          bottomStartAngle + i * (bottomArcAngle / (bottomCharCount - 1));

      final Offset charOffset = Offset(
        center.dx + bottomTextRadius * math.cos(charAngle),
        center.dy + bottomTextRadius * math.sin(charAngle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: char,
          style: GoogleFonts.shareTechMono(
            fontSize: radius * 0.085,
            color: paperColor,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                color: lineColor.withValues(alpha: 0.8),
                blurRadius: 2,
              ),
              Shadow(
                offset: const Offset(-1, -1),
                color: lineColor.withValues(alpha: 0.8),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      canvas.save();
      canvas.translate(charOffset.dx, charOffset.dy);
      canvas.rotate(charAngle - math.pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Дата в центре
    final dateText = TextSpan(
      text:
          '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}',
      style: GoogleFonts.shareTechMono(
        color: lineColor,
        fontSize: radius * 0.07,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        shadows: [
          Shadow(
            offset: const Offset(0.5, 0.5),
            color: shadowColor.withValues(alpha: 0.25),
            blurRadius: 1,
          ),
        ],
      ),
    );
    textPainter.text = dateText;
    textPainter.layout();

    final dateOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy + radius * 0.17,
    );
    textPainter.paint(canvas, dateOffset);
  }

  @override
  bool shouldRepaint(covariant _DaVinciClockPainter oldDelegate) => true;
}

class DaVinciDigitalClock extends StatefulWidget {
  final double size;

  const DaVinciDigitalClock({super.key, required this.size});

  @override
  State<DaVinciDigitalClock> createState() => _DaVinciDigitalClockState();
}

class _DaVinciDigitalClockState extends State<DaVinciDigitalClock> {
  late Timer _timer;
  DateTime _dateTime = DateTime.now();

  Duration _stopwatchElapsed = Duration.zero;
  Timer? _stopwatchTimer;
  bool _stopwatchRunning = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _dateTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatchTimer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    if (_stopwatchRunning) return;
    _stopwatchRunning = true;
    final startTime = DateTime.now().subtract(_stopwatchElapsed);
    _stopwatchTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _stopwatchElapsed = DateTime.now().difference(startTime);
      });
    });
  }

  void _stopStopwatch() {
    if (!_stopwatchRunning) return;
    _stopwatchRunning = false;
    _stopwatchTimer?.cancel();
  }

  void _resetStopwatch() {
    _stopStopwatch();
    setState(() {
      _stopwatchElapsed = Duration.zero;
    });
  }

  String _formatStopwatch(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = (d.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds:$milliseconds';
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = const Color(0xFF5B4636);
    final shadowColor = const Color(0xFF3A2F24);
    final paperColor = const Color(0xFFF4EBD9);

    final timeText =
        '${_dateTime.hour.toString().padLeft(2, '0')}:'
        '${_dateTime.minute.toString().padLeft(2, '0')}:'
        '${_dateTime.second.toString().padLeft(2, '0')}';

    final dateText =
        '${_dateTime.day.toString().padLeft(2, '0')}.'
        '${_dateTime.month.toString().padLeft(2, '0')}.'
        '${_dateTime.year}';

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: paperColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(vertical: widget.size * 0.07),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            // Смещение верхнего текста выше и вправо
            top: widget.size * -0.04,
            left: widget.size * 0.04,
            child: Text(
              'digital watch',
              style: GoogleFonts.orbitron(
                fontSize: widget.size * 0.045,
                fontWeight: FontWeight.w700,
                color: lineColor.withValues(alpha: 0.50),
                // shadows: [
                //   Shadow(
                //     offset: const Offset(1, 1),
                //     color: lineColor.withOpacity(0.4),
                //     blurRadius: 2,
                //   ),
                //   Shadow(
                //     offset: const Offset(-1, -1),
                //     color: lineColor.withOpacity(0.4),
                //     blurRadius: 2,
                //   ),
                // ],
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: widget.size * 0.015,
                ), // Отступ из-за верхнего текста
                // Время
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.size * 0.03),
                  child: Container(
                    width: widget.size * 1.0,
                    height: widget.size * 0.30,
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size * 0.03,
                      vertical: widget.size * 0.03,
                    ),
                    alignment: Alignment.center, // центрируем текст
                    decoration: BoxDecoration(
                      border: Border.all(color: lineColor, width: 3),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      timeText,
                      style: GoogleFonts.orbitron(
                        fontSize: widget.size * 0.15,
                        color: lineColor,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            offset: const Offset(1, 1),
                            color: shadowColor.withValues(alpha: 0.3),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis, // на случай длинного текста
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Дата
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.size * 0.04,
                    vertical: widget.size * 0.01,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lineColor.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    dateText,
                    style: GoogleFonts.shareTechMono(
                      fontSize: widget.size * 0.07,
                      color: lineColor.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          offset: const Offset(0.5, 0.5),
                          color: shadowColor.withValues(alpha: 0.25),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Секундомер
                Text(
                  _formatStopwatch(_stopwatchElapsed),
                  style: GoogleFonts.shareTechMono(
                    fontSize: widget.size * 0.1,
                    fontWeight: FontWeight.w700,
                    color: lineColor,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        offset: const Offset(0.5, 0.5),
                        color: shadowColor.withValues(alpha: 0.25),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Кнопки секундомера
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StopwatchIconButton(
                      icon: _stopwatchRunning ? Icons.pause : Icons.play_arrow,
                      tooltip: _stopwatchRunning ? 'Stop' : 'Start',
                      onPressed: () {
                        if (_stopwatchRunning) {
                          _stopStopwatch();
                        } else {
                          _startStopwatch();
                        }
                      },
                      enabled: true,
                      color: lineColor,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    _StopwatchIconButton(
                      icon: Icons.restart_alt,
                      tooltip: 'Reset',
                      onPressed: _resetStopwatch,
                      enabled: _stopwatchElapsed > Duration.zero,
                      color: lineColor,
                      size: 36,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            // Нижний текст ниже и вправо
            bottom: widget.size * -0.03,
            right: widget.size * 0.07,
            child: Text(
              'this watch app is written in flutter',
              textAlign: TextAlign.center,
              style: GoogleFonts.orbitron(
                fontSize: widget.size * 0.030,
                fontWeight: FontWeight.w600,
                color: lineColor.withValues(alpha: 0.50),
                // shadows: [
                //   Shadow(
                //     offset: const Offset(1, 1),
                //     color: lineColor.withOpacity(0.3),
                //     blurRadius: 1,
                //   ),
                //   Shadow(
                //     offset: const Offset(-1, -1),
                //     color: lineColor.withOpacity(0.3),
                //     blurRadius: 1,
                //   ),
                // ],
              ),
            ),
          ),
          Positioned(
            left: widget.size * 0.03,
            bottom: -widget.size * 0.04,
            width: widget.size * 0.16,
            height: widget.size * 0.16,
            child: Icon(
              Icons.flutter_dash,
              color: lineColor.withValues(alpha: 0.80),
              size: widget.size * 0.15,
            ),
          ),
        ],
      ),
    );
  }
}

class _StopwatchIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;
  final Color color;
  final String tooltip;
  final double size;

  const _StopwatchIconButton({
    required this.icon,
    required this.onPressed,
    required this.enabled,
    required this.color,
    required this.tooltip,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: color,
            shadowColor: Colors.transparent,
            shape: const CircleBorder(),
            side: BorderSide(color: color, width: 2),
            padding: EdgeInsets.zero,
            elevation: enabled ? 4 : 0,
          ),
          child: Icon(icon, size: size * 0.75),
        ),
      ),
    );
  }
}
