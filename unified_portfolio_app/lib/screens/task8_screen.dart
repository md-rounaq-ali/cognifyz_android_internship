import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Route _slideRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (c, a, s) => page,
  transitionDuration: const Duration(milliseconds: 400),
  transitionsBuilder: (c, a, s, child) => SlideTransition(position: a.drive(Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOutCubic))), child: child),
);

Route _fadeRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (c, a, s) => page,
  transitionDuration: const Duration(milliseconds: 400),
  transitionsBuilder: (c, a, s, child) => FadeTransition(opacity: a, child: child),
);

Route _scaleRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (c, a, s) => page,
  transitionDuration: const Duration(milliseconds: 400),
  transitionsBuilder: (c, a, s, child) => ScaleTransition(scale: a.drive(Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack))), child: child),
);

Route _slideUpRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (c, a, s) => page,
  transitionDuration: const Duration(milliseconds: 500),
  transitionsBuilder: (c, a, s, child) => SlideTransition(position: a.drive(Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))), child: child),
);

class Task8Screen extends StatelessWidget {
  const Task8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'title': 'Slide Right', 'subtitle': 'Horizontal slide transition', 'emoji': '➡️', 'color': const Color(0xFF6C63FF), 'route': _slideRoute},
      {'title': 'Fade Transition', 'subtitle': 'Smooth opacity cross-fade', 'emoji': '✨', 'color': const Color(0xFF00D4AA), 'route': _fadeRoute},
      {'title': 'Scale (Zoom In)', 'subtitle': 'Screen scales from center', 'emoji': '🔍', 'color': const Color(0xFFFF9F43), 'route': _scaleRoute},
      {'title': 'Slide Up', 'subtitle': 'Card slides from bottom', 'emoji': '⬆️', 'color': const Color(0xFFFF6B6B), 'route': _slideUpRoute},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A1500), Color(0xFF16130A)])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Task 8', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                  Text('Navigation', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                ]),
              ]),
              const SizedBox(height: 24),
              Text('Navigation\nPlayground', style: GoogleFonts.outfit(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800, height: 1.1)),
              Text('Tap to explore 4 transition types', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: navItems.map((item) {
                    final color = item['color'] as Color;
                    final routeFn = item['route'] as Route Function(Widget);
                    return _NavCard(
                      title: item['title'] as String,
                      subtitle: item['subtitle'] as String,
                      emoji: item['emoji'] as String,
                      color: color,
                      onTap: () => Navigator.push(context, routeFn(_DetailScreen(
                        title: item['title'] as String,
                        emoji: item['emoji'] as String,
                        color: color,
                      ))),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _NavCard extends StatefulWidget {
  final String title, subtitle, emoji;
  final Color color;
  final VoidCallback onTap;
  const _NavCard({required this.title, required this.subtitle, required this.emoji, required this.color, required this.onTap});

  @override
  State<_NavCard> createState() => _NavCardState();
}

class _NavCardState extends State<_NavCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) { setState(() => _isPressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: widget.color.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: widget.color.withOpacity(0.25))),
          child: Row(children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(color: widget.color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(widget.emoji, style: const TextStyle(fontSize: 24)))),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
              Text(widget.subtitle, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
            ])),
            Icon(Icons.arrow_forward_ios_rounded, color: widget.color, size: 15),
          ]),
        ),
      ),
    );
  }
}

class _DetailScreen extends StatelessWidget {
  final String title, emoji;
  final Color color;
  const _DetailScreen({required this.title, required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color.withOpacity(0.2), const Color(0xFF0D0D1A)])),
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
            Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
              const SizedBox(width: 16),
              Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            ]),
            Expanded(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15), border: Border.all(color: color.withOpacity(0.5), width: 2), boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 40)]),
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 48)))),
              const SizedBox(height: 28),
              Text(title, style: GoogleFonts.outfit(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
                child: Text('✅ Navigation working!', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w600))),
              const SizedBox(height: 32),
              ElevatedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded), label: Text('Go Back', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
            ]))),
          ])),
        ),
      ),
    );
  }
}
