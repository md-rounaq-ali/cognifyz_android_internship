import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ListDisplayApp());
}

class ListDisplayApp extends StatelessWidget {
  const ListDisplayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 3 - List Display',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00D4AA),
        brightness: Brightness.dark,
      ),
      home: const ListDisplayScreen(),
    );
  }
}

class TechItem {
  final String name;
  final String description;
  final String emoji;
  final String level;
  final Color color;
  final List<String> tags;

  const TechItem({
    required this.name,
    required this.description,
    required this.emoji,
    required this.level,
    required this.color,
    required this.tags,
  });
}

final List<TechItem> techItems = [
  TechItem(
    name: 'Flutter',
    description: 'Google\'s UI toolkit for building natively compiled apps for mobile, web, and desktop from a single codebase.',
    emoji: '💙',
    level: 'Core Framework',
    color: const Color(0xFF54C5F8),
    tags: ['Cross-platform', 'Dart', 'Hot Reload'],
  ),
  TechItem(
    name: 'Dart',
    description: 'A client-optimized language for fast apps on any platform, used as the programming language for Flutter.',
    emoji: '🎯',
    level: 'Language',
    color: const Color(0xFF6C63FF),
    tags: ['OOP', 'Async', 'Type-safe'],
  ),
  TechItem(
    name: 'SQLite',
    description: 'A self-contained, serverless SQL database engine used for local data storage in Android apps.',
    emoji: '🗄️',
    level: 'Database',
    color: const Color(0xFF00D4AA),
    tags: ['Local DB', 'CRUD', 'Sqflite'],
  ),
  TechItem(
    name: 'REST API',
    description: 'Architectural style for designing networked applications. Used to fetch and send data over the internet.',
    emoji: '🌐',
    level: 'Networking',
    color: const Color(0xFFFF6B6B),
    tags: ['HTTP', 'JSON', 'http package'],
  ),
  TechItem(
    name: 'Material Design 3',
    description: 'Google\'s latest design system that guides how app interfaces should look and feel on Android.',
    emoji: '🎨',
    level: 'UI Design',
    color: const Color(0xFFFFD700),
    tags: ['Widgets', 'Theming', 'Accessibility'],
  ),
  TechItem(
    name: 'State Management',
    description: 'Techniques for managing app state efficiently. Flutter offers setState, Provider, Riverpod, and Bloc.',
    emoji: '⚙️',
    level: 'Architecture',
    color: const Color(0xFFFF9F43),
    tags: ['setState', 'Provider', 'Bloc'],
  ),
  TechItem(
    name: 'Navigation',
    description: 'System for routing between different screens and pages in a Flutter application.',
    emoji: '🗺️',
    level: 'Routing',
    color: const Color(0xFF48CAE4),
    tags: ['Routes', 'Navigator', 'go_router'],
  ),
  TechItem(
    name: 'SharedPreferences',
    description: 'A Flutter plugin for reading and writing simple key-value pairs to persistent storage.',
    emoji: '💾',
    level: 'Storage',
    color: const Color(0xFFA29BFE),
    tags: ['Key-Value', 'Persistent', 'Simple'],
  ),
];

class ListDisplayScreen extends StatefulWidget {
  const ListDisplayScreen({super.key});

  @override
  State<ListDisplayScreen> createState() => _ListDisplayScreenState();
}

class _ListDisplayScreenState extends State<ListDisplayScreen> {
  String _searchQuery = '';
  String? _selectedLevel;

  List<TechItem> get filteredItems {
    return techItems.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLevel = _selectedLevel == null || item.level == _selectedLevel;
      return matchesSearch && matchesLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color(0xFF1C2128)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D4AA).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF00D4AA).withOpacity(0.4)),
                          ),
                          child: Text(
                            'Level 2 • Intermediate',
                            style: GoogleFonts.outfit(color: const Color(0xFF00D4AA), fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${filteredItems.length} items',
                            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tech Stack\nDirectory',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Android Development Technologies',
                      style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
                    ),
                    const SizedBox(height: 20),

                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: TextField(
                        style: GoogleFonts.outfit(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search technologies...',
                          hintStyle: GoogleFonts.outfit(color: Colors.white38),
                          prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        onChanged: (v) => setState(() => _searchQuery = v),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // List
              Expanded(
                child: filteredItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🔍', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 16),
                            Text('No results found', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return _TechCard(item: item, index: index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechCard extends StatefulWidget {
  final TechItem item;
  final int index;

  const _TechCard({required this.item, required this.index});

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _expandAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _isExpanded ? widget.item.color.withOpacity(0.08) : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isExpanded ? widget.item.color.withOpacity(0.4) : Colors.white.withOpacity(0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: widget.item.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(widget.item.emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: widget.item.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.item.level,
                            style: GoogleFonts.outfit(color: widget.item.color, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38),
                  ),
                ],
              ),

              SizeTransition(
                sizeFactor: _expandAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    Text(
                      widget.item.description,
                      style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13, height: 1.6),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.item.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.item.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: widget.item.color.withOpacity(0.3)),
                        ),
                        child: Text(tag, style: GoogleFonts.outfit(color: widget.item.color, fontSize: 11, fontWeight: FontWeight.w500)),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
