import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BasicUIApp());
}

class BasicUIApp extends StatelessWidget {
  const BasicUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 4 - Basic UI Layout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF9F43),
        brightness: Brightness.dark,
      ),
      home: const BasicUIScreen(),
    );
  }
}

class BasicUIScreen extends StatefulWidget {
  const BasicUIScreen({super.key});

  @override
  State<BasicUIScreen> createState() => _BasicUIScreenState();
}

class _BasicUIScreenState extends State<BasicUIScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const _PortfolioTab(),
    const _StatsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          indicatorColor: const Color(0xFFFF9F43).withOpacity(0.2),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined, color: Colors.white38),
              selectedIcon: const Icon(Icons.home_rounded, color: Color(0xFFFF9F43)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.dashboard_outlined, color: Colors.white38),
              selectedIcon: const Icon(Icons.dashboard_rounded, color: Color(0xFFFF9F43)),
              label: 'Portfolio',
            ),
            NavigationDestination(
              icon: const Icon(Icons.bar_chart_outlined, color: Colors.white38),
              selectedIcon: const Icon(Icons.bar_chart_rounded, color: Color(0xFFFF9F43)),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────── Home Tab ──────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9F43), Color(0xFFFF6B6B)],
                      ),
                      boxShadow: [BoxShadow(color: const Color(0xFFFF9F43).withOpacity(0.4), blurRadius: 20)],
                    ),
                    child: Center(
                      child: Text('MR', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Morning! 👋', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                        Text('Md Rounaq Ali', style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        Text('Android Development Intern', style: GoogleFonts.outfit(color: const Color(0xFFFF9F43), fontSize: 12)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.white54, size: 20),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Internship Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9F43), Color(0xFFFF6B6B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFFFF9F43).withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 10))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.business_center_rounded, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text('Cognifyz IT Solutions', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Internship Progress', style: GoogleFonts.outfit(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('8/8 Tasks Completed ✅', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 1.0,
                        minHeight: 8,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Deadline: 28 June 2026', style: GoogleFonts.outfit(color: Colors.white60, fontSize: 11)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text('Quick Access', style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),

              // Grid of Activity Cards
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                children: [
                  _buildGridCard('📱', 'Tasks', '8 Total', const Color(0xFF6C63FF)),
                  _buildGridCard('🏆', 'Level', 'Expert', const Color(0xFF00D4AA)),
                  _buildGridCard('📅', 'Duration', '1 Month', const Color(0xFFFF6B6B)),
                  _buildGridCard('💻', 'Mode', 'Remote', const Color(0xFFFFD700)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(String emoji, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
              Text(title, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────── Portfolio Tab ──────────────────────────────
class _PortfolioTab extends StatelessWidget {
  const _PortfolioTab();

  final List<Map<String, dynamic>> tasks = const [
    {'title': 'Hello World App', 'level': 'Level 1', 'status': 'Complete', 'color': Color(0xFF00D4AA)},
    {'title': 'Button Interaction', 'level': 'Level 1', 'status': 'Complete', 'color': Color(0xFF00D4AA)},
    {'title': 'List Display', 'level': 'Level 2', 'status': 'Complete', 'color': Color(0xFF6C63FF)},
    {'title': 'Basic UI Layout', 'level': 'Level 2', 'status': 'Complete', 'color': Color(0xFF6C63FF)},
    {'title': 'Fetch & Display Data', 'level': 'Level 3', 'status': 'Complete', 'color': Color(0xFFFF9F43)},
    {'title': 'Simple Form', 'level': 'Level 3', 'status': 'Complete', 'color': Color(0xFFFF9F43)},
    {'title': 'Database Usage', 'level': 'Level 4', 'status': 'Complete', 'color': Color(0xFFFF6B6B)},
    {'title': 'Navigation', 'level': 'Level 4', 'status': 'Complete', 'color': Color(0xFFFF6B6B)},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Task Portfolio', style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (task['color'] as Color).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('${index + 1}', style: GoogleFonts.outfit(color: task['color'] as Color, fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task['title'] as String, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                              Text(task['level'] as String, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D4AA).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('✅ ${task['status']}', style: GoogleFonts.outfit(color: const Color(0xFF00D4AA), fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────── Stats Tab ──────────────────────────────
class _StatsTab extends StatelessWidget {
  const _StatsTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A2E),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Stats', style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 24),
              Row(
                children: [
                  _statBox('8', 'Tasks\nCompleted', const Color(0xFF00D4AA)),
                  const SizedBox(width: 16),
                  _statBox('4', 'Levels\nCleared', const Color(0xFF6C63FF)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _statBox('100%', 'Completion\nRate', const Color(0xFFFFD700)),
                  const SizedBox(width: 16),
                  _statBox('A+', 'Expected\nGrade', const Color(0xFFFF6B6B)),
                ],
              ),
              const SizedBox(height: 28),
              Text('Level Progress', style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              _levelBar('Level 1 - Beginner', 1.0, const Color(0xFF00D4AA), '2/2'),
              _levelBar('Level 2 - Intermediate', 1.0, const Color(0xFF6C63FF), '2/2'),
              _levelBar('Level 3 - Advanced', 1.0, const Color(0xFFFF9F43), '2/2'),
              _levelBar('Level 4 - Expert', 1.0, const Color(0xFFFF6B6B), '2/2'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: GoogleFonts.outfit(color: color, fontSize: 36, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12, height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _levelBar(String label, double progress, Color color, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13)),
              Text(count, style: GoogleFonts.outfit(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
