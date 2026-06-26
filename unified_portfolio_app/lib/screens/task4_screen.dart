import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task4Screen extends StatefulWidget {
  const Task4Screen({super.key});

  @override
  State<Task4Screen> createState() => _Task4ScreenState();
}

class _Task4ScreenState extends State<Task4Screen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A1A2E), Color(0xFF16213E)])),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
                    const SizedBox(width: 16),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Task 4', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                      Text('Basic UI Layout', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    ]),
                  ],
                ),
              ),
              // Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: ['Home', 'Portfolio', 'Stats'].asMap().entries.map((e) => Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tab = e.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tab == e.key ? const Color(0xFFFF9F43) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(e.value, textAlign: TextAlign.center, style: GoogleFonts.outfit(color: _tab == e.key ? Colors.white : Colors.white38, fontWeight: _tab == e.key ? FontWeight.w700 : FontWeight.w400, fontSize: 13)),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: _tab == 0 ? _HomeTab() : _tab == 1 ? _PortfolioTab() : _StatsTab()),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFF9F43), Color(0xFFFF6B6B)]), borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: const Color(0xFFFF9F43).withOpacity(0.3), blurRadius: 20)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Internship Progress', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('8/8 Tasks Completed ✅', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 12),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: const LinearProgressIndicator(value: 1.0, minHeight: 8, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
            ]),
          ),
          const SizedBox(height: 20),
          Text('Quick Access', style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.2,
            children: [
              _gridCard('📱', 'Tasks', '8 Total', const Color(0xFF6C63FF)),
              _gridCard('🏆', 'Level', 'Expert', const Color(0xFF00D4AA)),
              _gridCard('📅', 'Duration', '1 Month', const Color(0xFFFF6B6B)),
              _gridCard('💻', 'Mode', 'Remote', const Color(0xFFFFD700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridCard(String emoji, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
          Text(title, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
        ]),
      ]),
    );
  }
}

class _PortfolioTab extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = const [
    {'title': 'Hello World', 'level': 'Level 1', 'color': Color(0xFF00D4AA)},
    {'title': 'Button Interaction', 'level': 'Level 1', 'color': Color(0xFF00D4AA)},
    {'title': 'List Display', 'level': 'Level 2', 'color': Color(0xFF6C63FF)},
    {'title': 'Basic UI Layout', 'level': 'Level 2', 'color': Color(0xFF6C63FF)},
    {'title': 'Fetch Data', 'level': 'Level 3', 'color': Color(0xFFFF9F43)},
    {'title': 'Simple Form', 'level': 'Level 3', 'color': Color(0xFFFF9F43)},
    {'title': 'Database Usage', 'level': 'Level 4', 'color': Color(0xFFFF6B6B)},
    {'title': 'Navigation', 'level': 'Level 4', 'color': Color(0xFFFF6B6B)},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: tasks.length,
      itemBuilder: (ctx, i) {
        final t = tasks[i];
        final color = t['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.08))),
          child: Row(children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Center(child: Text('${i + 1}', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800)))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t['title'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              Text(t['level'] as String, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
            ])),
            const Text('✅', style: TextStyle(fontSize: 16)),
          ]),
        );
      },
    );
  }
}

class _StatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _stat('8', 'Tasks\nDone', const Color(0xFF00D4AA)),
            const SizedBox(width: 12),
            _stat('4', 'Levels', const Color(0xFF6C63FF)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            _stat('100%', 'Rate', const Color(0xFFFFD700)),
            const SizedBox(width: 12),
            _stat('A+', 'Grade', const Color(0xFFFF6B6B)),
          ]),
          const SizedBox(height: 20),
          ...[
            ['Level 1 - Beginner', const Color(0xFF00D4AA), '2/2'],
            ['Level 2 - Intermediate', const Color(0xFF6C63FF), '2/2'],
            ['Level 3 - Advanced', const Color(0xFFFF9F43), '2/2'],
            ['Level 4 - Expert', const Color(0xFFFF6B6B), '2/2'],
          ].map((l) => _levelBar(l[0] as String, l[1] as Color, l[2] as String)),
        ],
      ),
    );
  }

  Widget _stat(String val, String label, Color color) {
    return Expanded(
      child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(val, style: GoogleFonts.outfit(color: color, fontSize: 30, fontWeight: FontWeight.w800)),
          Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12, height: 1.4)),
        ]),
      ),
    );
  }

  Widget _levelBar(String label, Color color, String count) {
    return Container(margin: const EdgeInsets.only(bottom: 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13)),
        Text(count, style: GoogleFonts.outfit(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: 1.0, minHeight: 8, backgroundColor: Colors.white12, valueColor: AlwaysStoppedAnimation<Color>(color))),
    ]));
  }
}
