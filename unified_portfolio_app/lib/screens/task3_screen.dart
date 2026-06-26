import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Task3Screen extends StatefulWidget {
  const Task3Screen({super.key});

  @override
  State<Task3Screen> createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> _techItems = const [
    {'name': 'Flutter', 'desc': 'Google\'s UI toolkit for cross-platform apps.', 'emoji': '💙', 'level': 'Framework', 'color': Color(0xFF54C5F8), 'tags': ['Cross-platform', 'Dart', 'Hot Reload']},
    {'name': 'Dart', 'desc': 'Client-optimized language used with Flutter.', 'emoji': '🎯', 'level': 'Language', 'color': Color(0xFF6C63FF), 'tags': ['OOP', 'Async', 'Type-safe']},
    {'name': 'SQLite', 'desc': 'Lightweight local database for Android apps.', 'emoji': '🗄️', 'level': 'Database', 'color': Color(0xFF00D4AA), 'tags': ['Local DB', 'CRUD', 'sqflite']},
    {'name': 'REST API', 'desc': 'Fetch remote data over the internet using HTTP.', 'emoji': '🌐', 'level': 'Networking', 'color': Color(0xFFFF6B6B), 'tags': ['HTTP', 'JSON', 'http package']},
    {'name': 'Material 3', 'desc': 'Google\'s modern design system for Android.', 'emoji': '🎨', 'level': 'UI Design', 'color': Color(0xFFFFD700), 'tags': ['Widgets', 'Theming', 'Accessibility']},
    {'name': 'State Mgmt', 'desc': 'Managing UI state in Flutter applications.', 'emoji': '⚙️', 'level': 'Architecture', 'color': Color(0xFFFF9F43), 'tags': ['setState', 'Provider', 'Bloc']},
    {'name': 'Navigation', 'desc': 'Routing between screens in Flutter.', 'emoji': '🗺️', 'level': 'Routing', 'color': Color(0xFF48CAE4), 'tags': ['Routes', 'Navigator', 'go_router']},
    {'name': 'SharedPrefs', 'desc': 'Key-value storage for user preferences.', 'emoji': '💾', 'level': 'Storage', 'color': Color(0xFFA29BFE), 'tags': ['Key-Value', 'Persistent', 'Simple']},
  ];

  List<Map<String, dynamic>> get _filtered => _techItems
      .where((i) => i['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) || i['desc'].toString().toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0D1117), Color(0xFF1C2128)])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
                        const SizedBox(width: 16),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Task 3', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                          Text('List Display', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                        ]),
                        const Spacer(),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF00D4AA).withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Text('${_filtered.length} items', style: GoogleFonts.outfit(color: const Color(0xFF00D4AA), fontSize: 11))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.1))),
                      child: TextField(
                        style: GoogleFonts.outfit(color: Colors.white),
                        decoration: InputDecoration(hintText: 'Search technologies...', hintStyle: GoogleFonts.outfit(color: Colors.white38), prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                        onChanged: (v) => setState(() => _searchQuery = v),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _filtered.length,
                  itemBuilder: (context, index) => _TechCard(item: _filtered[index]),
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
  final Map<String, dynamic> item;
  const _TechCard({required this.item});

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _expandAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final color = widget.item['color'] as Color;
    final tags = widget.item['tags'] as List<String>;
    return GestureDetector(
      onTap: () { setState(() { _isExpanded = !_isExpanded; _isExpanded ? _ctrl.forward() : _ctrl.reverse(); }); },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isExpanded ? color.withOpacity(0.08) : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _isExpanded ? color.withOpacity(0.4) : Colors.white.withOpacity(0.08)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 46, height: 46, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(widget.item['emoji'] as String, style: const TextStyle(fontSize: 22)))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.item['name'] as String, style: GoogleFonts.outfit(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              Container(margin: const EdgeInsets.only(top: 3), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                child: Text(widget.item['level'] as String, style: GoogleFonts.outfit(color: color, fontSize: 10, fontWeight: FontWeight.w600))),
            ])),
            AnimatedRotation(turns: _isExpanded ? 0.5 : 0, duration: const Duration(milliseconds: 300), child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38)),
          ]),
          SizeTransition(sizeFactor: _expandAnim, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 12),
            Text(widget.item['desc'] as String, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13, height: 1.5)),
            const SizedBox(height: 10),
            Wrap(spacing: 6, runSpacing: 6, children: tags.map((tag) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.3))), child: Text(tag, style: GoogleFonts.outfit(color: color, fontSize: 11)))).toList()),
          ])),
        ]),
      ),
    );
  }
}
