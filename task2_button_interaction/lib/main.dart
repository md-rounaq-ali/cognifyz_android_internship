import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ButtonInteractionApp());
}

class ButtonInteractionApp extends StatelessWidget {
  const ButtonInteractionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 2 - Button Interaction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF6B6B),
        brightness: Brightness.dark,
      ),
      home: const ButtonInteractionScreen(),
    );
  }
}

class ButtonInteractionScreen extends StatefulWidget {
  const ButtonInteractionScreen({super.key});

  @override
  State<ButtonInteractionScreen> createState() => _ButtonInteractionScreenState();
}

class _ButtonInteractionScreenState extends State<ButtonInteractionScreen>
    with TickerProviderStateMixin {
  int _clickCount = 0;
  int _totalPoints = 0;
  String _message = 'Tap the button below!';
  String _emoji = '👆';
  bool _isPressed = false;

  late AnimationController _pulseController;
  late AnimationController _countController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _countScaleAnimation;

  final List<Map<String, dynamic>> _milestones = [
    {'count': 1, 'message': 'First click! Great start! 🎉', 'emoji': '🎉', 'color': Color(0xFF00D4AA)},
    {'count': 5, 'message': 'Five clicks! You\'re on fire! 🔥', 'emoji': '🔥', 'color': Color(0xFFFF6B6B)},
    {'count': 10, 'message': 'Ten clicks! Amazing! 🏆', 'emoji': '🏆', 'color': Color(0xFFFFD700)},
    {'count': 25, 'message': 'Twenty-five! Incredible! ⚡', 'emoji': '⚡', 'color': Color(0xFF6C63FF)},
    {'count': 50, 'message': 'Fifty clicks! You\'re a legend! 👑', 'emoji': '👑', 'color': Color(0xFFFF6B6B)},
  ];

  Color _buttonColor = const Color(0xFF6C63FF);

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _countScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _countController, curve: Curves.elasticOut),
    );
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

    // Check milestones
    for (var milestone in _milestones) {
      if (_clickCount == milestone['count']) {
        setState(() {
          _message = milestone['message'] as String;
          _emoji = milestone['emoji'] as String;
          _buttonColor = milestone['color'] as Color;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text(milestone['emoji'] as String, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    milestone['message'] as String,
                    style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            backgroundColor: milestone['color'] as Color,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isPressed = false;
          if (_clickCount != 1 && _clickCount != 5 && _clickCount != 10 &&
              _clickCount != 25 && _clickCount != 50) {
            _message = 'Clicked $_clickCount time${_clickCount == 1 ? '' : 's'}! Keep going!';
            _emoji = '💫';
            _buttonColor = const Color(0xFF6C63FF);
          }
        });
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _clickCount = 0;
      _totalPoints = 0;
      _message = 'Tap the button below!';
      _emoji = '👆';
      _buttonColor = const Color(0xFF6C63FF);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Counter reset! Start again 🔄', style: GoogleFonts.outfit()),
        backgroundColor: Colors.blueGrey[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Task 2', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                        Text(
                          'Button Interaction',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _resetCounter,
                      icon: const Icon(Icons.refresh_rounded, color: Colors.white54),
                      tooltip: 'Reset',
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Stats Row
                Row(
                  children: [
                    _buildStatCard('Clicks', _clickCount.toString(), Icons.touch_app_rounded, const Color(0xFF6C63FF)),
                    const SizedBox(width: 16),
                    _buildStatCard('Points', _totalPoints.toString(), Icons.stars_rounded, const Color(0xFFFFD700)),
                  ],
                ),

                const SizedBox(height: 32),

                // Message Card
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _buttonColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _buttonColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Text(_emoji, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _message,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Main Click Button
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: GestureDetector(
                    onTap: _onButtonPressed,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _buttonColor,
                            _buttonColor.withOpacity(0.7),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _buttonColor.withOpacity(_isPressed ? 0.8 : 0.4),
                            blurRadius: _isPressed ? 60 : 30,
                            spreadRadius: _isPressed ? 10 : 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.touch_app_rounded,
                              size: 60,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'CLICK ME',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Next Milestone
                _buildNextMilestone(),

                const Spacer(),

                Text(
                  'Cognifyz IT Solutions Pvt. Ltd.',
                  style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            ScaleTransition(
              scale: _countScaleAnimation,
              child: Text(
                value,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildNextMilestone() {
    int nextMilestone = 1;
    for (var m in _milestones) {
      if (m['count'] as int > _clickCount) {
        nextMilestone = m['count'] as int;
        break;
      }
    }
    if (nextMilestone <= _clickCount) nextMilestone = 100;

    double progress = _clickCount / nextMilestone;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Milestone', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
              Text('$_clickCount / $nextMilestone', style: GoogleFonts.outfit(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            ),
          ),
        ],
      ),
    );
  }
}
