import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> with TickerProviderStateMixin {
  int _clickCount = 0;
  int _totalPoints = 0;
  String _message = 'Tap the button below!';
  String _emoji = '👆';
  Color _buttonColor = const Color(0xFF6C63FF);
  bool _isPressed = false;

  late AnimationController _pulseController;
  late AnimationController _countController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _countScaleAnimation;

  final List<Map<String, dynamic>> _milestones = [
    {'count': 1, 'message': 'First click! Great start! 🎉', 'emoji': '🎉', 'color': Color(0xFF00D4AA)},
    {'count': 5, 'message': 'Five clicks! You\'re on fire! 🔥', 'emoji': '🔥', 'color': Color(0xFFFF6B6B)},
    {'count': 10, 'message': 'Ten clicks! Amazing! 🏆', 'emoji': '🏆', 'color': Color(0xFFFFD700)},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _countController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _countScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(CurvedAnimation(parent: _countController, curve: Curves.elasticOut));
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    HapticFeedback.lightImpact();
    setState(() {
      _clickCount++;
      _totalPoints += 10;
      _isPressed = true;
      _buttonColor = const Color(0xFF00D4AA);
    });
    _countController.forward(from: 0);

    for (var milestone in _milestones) {
      if (_clickCount == milestone['count']) {
        setState(() {
          _message = milestone['message'] as String;
          _emoji = milestone['emoji'] as String;
          _buttonColor = milestone['color'] as Color;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: [
            Text(milestone['emoji'] as String, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(child: Text(milestone['message'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600))),
          ]),
          backgroundColor: milestone['color'] as Color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ));
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) setState(() { _isPressed = false; if (_clickCount != 1 && _clickCount != 5 && _clickCount != 10) { _message = 'Clicked $_clickCount times!'; _emoji = '💫'; _buttonColor = const Color(0xFF6C63FF); } });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
                    const SizedBox(width: 16),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Task 2', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                      Text('Button Interaction', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    ]),
                    const Spacer(),
                    IconButton(onPressed: () => setState(() { _clickCount = 0; _totalPoints = 0; _message = 'Tap the button below!'; _emoji = '👆'; _buttonColor = const Color(0xFF6C63FF); }), icon: const Icon(Icons.refresh_rounded, color: Colors.white54)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _statCard('Clicks', _clickCount.toString(), Icons.touch_app_rounded, const Color(0xFF6C63FF)),
                    const SizedBox(width: 16),
                    _statCard('Points', _totalPoints.toString(), Icons.stars_rounded, const Color(0xFFFFD700)),
                  ],
                ),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: _buttonColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: _buttonColor.withOpacity(0.3))),
                  child: Row(children: [
                    Text(_emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(child: Text(_message, style: GoogleFonts.outfit(color: Colors.white, fontSize: 15))),
                  ]),
                ),
                const Spacer(),
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: GestureDetector(
                    onTap: _onButtonPressed,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_buttonColor, _buttonColor.withOpacity(0.7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: [BoxShadow(color: _buttonColor.withOpacity(_isPressed ? 0.8 : 0.4), blurRadius: _isPressed ? 60 : 30, spreadRadius: _isPressed ? 10 : 0)],
                      ),
                      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.touch_app_rounded, size: 54, color: Colors.white.withOpacity(0.9)),
                        const SizedBox(height: 6),
                        Text('CLICK ME', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: 2)),
                      ])),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          ScaleTransition(scale: _countScaleAnimation, child: Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800))),
          Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
        ]),
      ),
    );
  }
}
