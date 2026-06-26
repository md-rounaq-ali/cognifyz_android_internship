import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task1_screen.dart';
import 'task2_screen.dart';
import 'task3_screen.dart';
import 'task4_screen.dart';
import 'task5_screen.dart';
import 'task6_screen.dart';
import 'task7_screen.dart';
import 'task8_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static Route _slideRoute(Widget page) {
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

  final List<Map<String, dynamic>> _taskItems = const [
    {
      'number': 1,
      'title': 'Hello World App',
      'subtitle': 'Basic welcome screen with animations',
      'level': 'Level 1 • Beginner',
      'emoji': '👋',
      'color': Color(0xFF6C63FF),
    },
    {
      'number': 2,
      'title': 'Button Interaction',
      'subtitle': 'Interactive button with counter & milestones',
      'level': 'Level 1 • Beginner',
      'emoji': '🖱️',
      'color': Color(0xFFFF6B6B),
    },
    {
      'number': 3,
      'title': 'List Display',
      'subtitle': 'Expandable tech stack directory',
      'level': 'Level 2 • Intermediate',
      'emoji': '📋',
      'color': Color(0xFF00D4AA),
    },
    {
      'number': 4,
      'title': 'Basic UI Layout',
      'subtitle': 'Multi-tab dashboard with grid views',
      'level': 'Level 2 • Intermediate',
      'emoji': '🎨',
      'color': Color(0xFFFF9F43),
    },
    {
      'number': 5,
      'title': 'Fetch & Display Data',
      'subtitle': 'Live API data with loading states',
      'level': 'Level 3 • Advanced',
      'emoji': '🌐',
      'color': Color(0xFF48CAE4),
    },
    {
      'number': 6,
      'title': 'Simple Form',
      'subtitle': 'Form with full validation & success state',
      'level': 'Level 3 • Advanced',
      'emoji': '📝',
      'color': Color(0xFFA29BFE),
    },
    {
      'number': 7,
      'title': 'Database Usage',
      'subtitle': 'SQLite CRUD operations with local storage',
      'level': 'Level 4 • Expert',
      'emoji': '🗄️',
      'color': Color(0xFFFF6B6B),
    },
    {
      'number': 8,
      'title': 'Navigation',
      'subtitle': 'Custom slide, fade, zoom transitions',
      'level': 'Level 4 • Expert',
      'emoji': '🗺️',
      'color': Color(0xFFFFD700),
    },
  ];

  Widget _getScreen(int number) {
    switch (number) {
      case 1: return const Task1Screen();
      case 2: return const Task2Screen();
      case 3: return const Task3Screen();
      case 4: return const Task4Screen();
      case 5: return const Task5Screen();
      case 6: return const Task6Screen();
      case 7: return const Task7Screen();
      case 8: return const Task8Screen();
      default: return const Task1Screen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D1A), Color(0xFF1A1A2E), Color(0xFF0F1923)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header Sliver
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top badge
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF00D4AA)]),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('🏢 Cognifyz IT Solutions', style: GoogleFonts.outfit(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Internship\nPortfolio',
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800, height: 1.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Md Rounaq Ali • Ref: CTI/A1/C361826',
                        style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
                      ),
                      const SizedBox(height: 24),

                      // Hero Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF00D4AA)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.4), blurRadius: 30, offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('🎓', style: TextStyle(fontSize: 32)),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                                  child: Text('Android Dev', style: GoogleFonts.outfit(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('8/8 Tasks Complete', style: GoogleFonts.outfit(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 8),
                            Text('28 May – 28 June 2026 • Flutter & Dart', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: const LinearProgressIndicator(
                                value: 1.0,
                                minHeight: 10,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('100% Completion Rate', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Stats Row
                      Row(
                        children: [
                          _statCard('4', 'Levels', const Color(0xFF6C63FF)),
                          const SizedBox(width: 12),
                          _statCard('8', 'Tasks', const Color(0xFF00D4AA)),
                          const SizedBox(width: 12),
                          _statCard('100%', 'Done', const Color(0xFFFFD700)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Text('All Tasks', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text('Tap any task to explore it', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Task Cards List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = _taskItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _TaskCard(
                        task: task,
                        onTap: () => Navigator.push(context, _slideRoute(_getScreen(task['number'] as int))),
                      ),
                    );
                  },
                  childCount: _taskItems.length,
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Column(
                          children: [
                            const Text('🏆', style: TextStyle(fontSize: 36)),
                            const SizedBox(height: 12),
                            Text('Internship Complete!', style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('All tasks submitted for evaluation', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13)),
                            const SizedBox(height: 12),
                            Text('Submission: https://forms.gle/c3QZCheEySRDPV6V6', style: GoogleFonts.outfit(color: const Color(0xFF6C63FF), fontSize: 11), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Cognifyz IT Solutions Pvt. Ltd.', style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.outfit(color: color, fontSize: 24, fontWeight: FontWeight.w800)),
            Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatefulWidget {
  final Map<String, dynamic> task;
  final VoidCallback onTap;

  const _TaskCard({required this.task, required this.onTap});

  @override
  State<_TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<_TaskCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.task['color'] as Color;

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
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _isPressed ? color.withOpacity(0.12) : Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isPressed ? color.withOpacity(0.4) : Colors.white.withOpacity(0.08),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Center(child: Text(widget.task['emoji'] as String, style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                          child: Text('Task ${widget.task['number']}', style: GoogleFonts.outfit(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFF00D4AA).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                          child: Text('✅', style: const TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(widget.task['title'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(widget.task['subtitle'] as String, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(widget.task['level'] as String, style: GoogleFonts.outfit(color: color.withOpacity(0.7), fontSize: 11)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
