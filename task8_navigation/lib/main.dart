import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const NavigationApp());
}

// ─────────────── Custom Route Builders ───────────────
Route _slideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (ctx, anim, sec) => page,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (ctx, anim, sec, child) {
      final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOutCubic));
      return SlideTransition(position: anim.drive(tween), child: child);
    },
  );
}

Route _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (ctx, anim, sec) => page,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (ctx, anim, sec, child) {
      return FadeTransition(opacity: anim, child: child);
    },
  );
}

Route _scaleRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (ctx, anim, sec) => page,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (ctx, anim, sec, child) {
      final tween = Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOutBack));
      return ScaleTransition(scale: anim.drive(tween), child: child);
    },
  );
}

Route _slideUpRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (ctx, anim, sec) => page,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (ctx, anim, sec, child) {
      final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(position: anim.drive(tween), child: child);
    },
  );
}

// ─────────────── App ───────────────
class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 8 - Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFFD700),
        brightness: Brightness.dark,
      ),
      home: const NavigationHomeScreen(),
    );
  }
}

// ─────────────── Home Screen ───────────────
class NavigationHomeScreen extends StatelessWidget {
  const NavigationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1500), Color(0xFF1E1A00), Color(0xFF16130A)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4)),
                  ),
                  child: Text('Level 4 • Expert', style: GoogleFonts.outfit(color: const Color(0xFFFFD700), fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 16),
                Text('Navigation\nPlayground', style: GoogleFonts.outfit(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w800, height: 1.1)),
                const SizedBox(height: 8),
                Text('Explore 4 custom transition animations', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),

                const SizedBox(height: 32),

                // Navigation Cards
                Expanded(
                  child: ListView(
                    children: [
                      _NavCard(
                        title: 'Slide Right',
                        subtitle: 'Classic horizontal slide transition',
                        emoji: '➡️',
                        color: const Color(0xFF6C63FF),
                        onTap: () => Navigator.push(context, _slideRoute(
                          const _DetailScreen(title: 'Slide Right', emoji: '➡️', color: Color(0xFF6C63FF), animType: 'Slide Right'),
                        )),
                      ),
                      const SizedBox(height: 14),
                      _NavCard(
                        title: 'Fade Transition',
                        subtitle: 'Smooth opacity cross-fade effect',
                        emoji: '✨',
                        color: const Color(0xFF00D4AA),
                        onTap: () => Navigator.push(context, _fadeRoute(
                          const _DetailScreen(title: 'Fade Transition', emoji: '✨', color: Color(0xFF00D4AA), animType: 'Fade'),
                        )),
                      ),
                      const SizedBox(height: 14),
                      _NavCard(
                        title: 'Scale (Zoom In)',
                        subtitle: 'Screen scales up from center',
                        emoji: '🔍',
                        color: const Color(0xFFFF9F43),
                        onTap: () => Navigator.push(context, _scaleRoute(
                          const _DetailScreen(title: 'Scale (Zoom In)', emoji: '🔍', color: Color(0xFFFF9F43), animType: 'Scale / Zoom'),
                        )),
                      ),
                      const SizedBox(height: 14),
                      _NavCard(
                        title: 'Slide Up',
                        subtitle: 'Card slides up from the bottom',
                        emoji: '⬆️',
                        color: const Color(0xFFFF6B6B),
                        onTap: () => Navigator.push(context, _slideUpRoute(
                          const _DetailScreen(title: 'Slide Up', emoji: '⬆️', color: Color(0xFFFF6B6B), animType: 'Slide Up'),
                        )),
                      ),
                      const SizedBox(height: 14),

                      // Named route demo
                      _NavCard(
                        title: 'About Screen',
                        subtitle: 'Navigate using pushNamed() route',
                        emoji: 'ℹ️',
                        color: const Color(0xFFFFD700),
                        onTap: () => Navigator.push(context, _fadeRoute(const _AboutScreen())),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Center(child: Text('Cognifyz IT Solutions Pvt. Ltd.', style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────── Nav Card ───────────────
class _NavCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.onTap,
  });

  @override
  State<_NavCard> createState() => _NavCardState();
}

class _NavCardState extends State<_NavCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.color.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(widget.emoji, style: const TextStyle(fontSize: 26))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    Text(widget.subtitle, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: widget.color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────── Detail Screen ───────────────
class _DetailScreen extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final String animType;

  const _DetailScreen({
    required this.title,
    required this.emoji,
    required this.color,
    required this.animType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.2), const Color(0xFF0D0D1A)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withOpacity(0.15),
                            border: Border.all(color: color.withOpacity(0.5), width: 2),
                            boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 40)],
                          ),
                          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 50))),
                        ),
                        const SizedBox(height: 32),
                        Text('$animType Transition', style: GoogleFonts.outfit(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color.withOpacity(0.3)),
                          ),
                          child: Text('✅ Navigation working!', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'This screen was navigated to\nusing a custom $animType animation\nwith PageRouteBuilder.',
                          style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14, height: 1.7),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                          label: Text('Go Back', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────── About Screen ───────────────
class _AboutScreen extends StatelessWidget {
  const _AboutScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1628), Color(0xFF1A2440)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text('About', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF00D4AA)]),
                            boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.4), blurRadius: 30)],
                          ),
                          child: Center(
                            child: Text('MR', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 32)),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text('Md Rounaq Ali', style: GoogleFonts.outfit(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
                        Text('Android Development Intern', style: GoogleFonts.outfit(color: const Color(0xFF6C63FF), fontSize: 14)),
                        const SizedBox(height: 8),
                        Text('Ref: CTI/A1/C361826', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Column(
                            children: [
                              _aboutRow('🏢', 'Company', 'Cognifyz IT Solutions Pvt. Ltd.'),
                              _aboutRow('📅', 'Duration', '28 May – 28 June 2026'),
                              _aboutRow('💻', 'Mode', 'Remote Work'),
                              _aboutRow('🎯', 'Tasks', '8/8 Completed'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Text('$label:', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
