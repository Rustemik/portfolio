import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF4EBD9),
      body: SafeArea(child: Center(child: DaVinciClockSwitcherSuper())),
    ),
  ),
);

class DaVinciClockSwitcherSuper extends StatefulWidget {
  const DaVinciClockSwitcherSuper({super.key});

  @override
  State<DaVinciClockSwitcherSuper> createState() =>
      _DaVinciClockSwitcherState();
}

class _DaVinciClockSwitcherState extends State<DaVinciClockSwitcherSuper> {
  bool _showAnalog = true;

  @override
  Widget build(BuildContext context) {
    final size = math.min(MediaQuery.of(context).size.width, 320.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width:
              size +
              (_showAnalog ? 80 : 0), // место под крутилку если аналоговые
          height: size,
          child: _showAnalog
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Добавляем крутилку слева
                    WindKnobVertical(size: 60),
                    const SizedBox(width: 20),
                    DaVinciAnalogClock(size: size),
                  ],
                )
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

/// Крутилка, которая вращается при вертикальном движении пальца.
/// Вращение визуальное, НЕ влияет на часы.
class WindKnobVertical extends StatefulWidget {
  final double size;

  const WindKnobVertical({super.key, required this.size});

  @override
  State<WindKnobVertical> createState() => _WindKnobVerticalState();
}

class _WindKnobVerticalState extends State<WindKnobVertical> {
  double _rotation = 0; // угол в радиан

  double _lastDy = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        _lastDy = details.localPosition.dy;
      },
      onVerticalDragUpdate: (details) {
        final dy = details.localPosition.dy;
        final delta = dy - _lastDy;
        setState(() {
          // Изменяем угол вращения пропорционально движению вверх/вниз
          _rotation += delta * 0.02;
          // Ограничим угол в пределах 0..2π для красоты
          _rotation %= 2 * math.pi;
        });
        _lastDy = dy;
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Transform.rotate(
          angle: _rotation,
          child: CustomPaint(painter: _KnobPainter()),
        ),
      ),
    );
  }
}

class _KnobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintKnob = Paint()
      ..color = const Color(0xFF5B4636)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paintKnob);

    // Ручка крутилки — вытянутый овал сверху круга
    final handleWidth = radius * 0.3;
    final handleHeight = radius * 1.3;
    final handleRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - radius * 0.7),
      width: handleWidth,
      height: handleHeight,
    );
    final paintHandle = Paint()..color = const Color(0xFFF4EBD9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(handleRect, Radius.circular(handleWidth / 2)),
      paintHandle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
      setState(() {
        _dateTime = DateTime.now();
      });
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

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final dialPaint = Paint()
      ..color = const Color(0xFF5B4636)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final fillPaint = Paint()
      ..color = const Color(0xFFF4EBD9)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, dialPaint);

    final hourHandPaint = Paint()
      ..color = const Color(0xFF5B4636)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final minuteHandPaint = Paint()
      ..color = const Color(0xFF5B4636)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final secondHandPaint = Paint()
      ..color = const Color(0xFF5B4636)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final hour = dateTime.hour % 12;
    final minute = dateTime.minute;
    final second = dateTime.second;
    final millisecond = dateTime.millisecond;

    final hourAngle = (hour + minute / 60) * 30 * math.pi / 180;
    final minuteAngle = (minute + second / 60) * 6 * math.pi / 180;
    final secondAngle =
        (second + millisecond / 1000) * 6 * math.pi / 180; // плавный ход

    final hourHandLength = radius * 0.5;
    final minuteHandLength = radius * 0.7;
    final secondHandLength = radius * 0.85;

    final hourHandEnd =
        center +
        Offset(math.sin(hourAngle), -math.cos(hourAngle)) * hourHandLength;
    final minuteHandEnd =
        center +
        Offset(math.sin(minuteAngle), -math.cos(minuteAngle)) *
            minuteHandLength;
    final secondHandEnd =
        center +
        Offset(math.sin(secondAngle), -math.cos(secondAngle)) *
            secondHandLength;

    canvas.drawLine(center, hourHandEnd, hourHandPaint);
    canvas.drawLine(center, minuteHandEnd, minuteHandPaint);
    canvas.drawLine(center, secondHandEnd, secondHandPaint);

    // Нарисуем точки для часов (12 точек)
    final dotPaint = Paint()..color = const Color(0xFF5B4636);
    final dotRadius = 4.0;
    for (int i = 0; i < 12; i++) {
      final angle = i * 30 * math.pi / 180;
      final offset =
          center + Offset(math.sin(angle), -math.cos(angle)) * (radius - 10);
      canvas.drawCircle(offset, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DaVinciClockPainter oldDelegate) =>
      oldDelegate.dateTime != dateTime;
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

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeString =
        '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}:${_dateTime.second.toString().padLeft(2, '0')}';

    return Container(
      width: widget.size,
      height: widget.size / 3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF5B4636),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        timeString,
        style: GoogleFonts.shareTechMono(
          fontSize: widget.size / 5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFF4EBD9),
        ),
      ),
    );
  }
}
